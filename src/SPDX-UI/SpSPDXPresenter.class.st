"
Main Spec2 presenter for the application. It holds a toolbar for actions, the table of licenses and a presenter for displaying the selected license text and comments.

Internal Representation and Key Implementation Points.

    Instance Variables
	licensePresenter:		<Object>
	licenseTable:		<Object>
	toolbar:		<Object>


    Implementation Points
"
Class {
	#name : #SpSPDXPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'licensePresenter',
		'toolbar',
		'licenseTable'
	],
	#category : #'SPDX-UI'
}

{ #category : #specs }
SpSPDXPresenter class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		add: #toolbar height: self toolbarHeight + 10;
		add: (SpPanedLayout newLeftToRight 
			add: #licenseTable;
			add: #licensePresenter;
			yourself);
		yourself
]

{ #category : #specs }
SpSPDXPresenter class >> open [
	<script>

	self new openWithSpec
]

{ #category : #initialization }
SpSPDXPresenter >> aboutSpdxLicenseSelectorText [

	^ 'A Pharo application to browse, search, inspect and select software artifacts licenses.
	
Version: ' , self versionString , '
URL: https://github.com/hernanmd/license-selector.
Author: Hernán Morales Durand'
]

{ #category : #'accessing - table' }
SpSPDXPresenter >> addLicenseColumns [

	licenseTable
		addColumn: (SpStringTableColumn new  
			title: 'Identifier'; 
			evaluated: [ :each | each licenseId ];
			sortFunction: #licenseId ascending;
			width: 50;			
			yourself);	
		addColumn: (SpStringTableColumn new  
			title: 'License Name'; 
			evaluated: [ :each | each licenseName ];
			sortFunction: #licenseName ascending;
			width: 60;			
			yourself);
		addColumn: (SpStringTableColumn new  
			title: 'OSI Approved'; 
			evaluated: [ :each | each isOsiApproved ];
			sortFunction: #printString ascending;
			width: 50;			
			yourself);
		addColumn: (SpStringTableColumn new  
			title: 'Deprecated'; 
			evaluated: [ :each | each isDeprecatedLicenseId ];
			sortFunction: #isDeprecatedLicenseId ascending;
			width: 50;			
			yourself);
		addColumn: (SpStringTableColumn new  
			title: 'URL'; 
			evaluated: [ : each | 
				(each seeAlso isNotNil and: [ each seeAlso isNotEmpty ])
					ifTrue: [ each seeAlso first ]
					ifFalse: [ String empty ] ];
			width: 100;
			yourself)
]

{ #category : #'accessing - toolbar' }
SpSPDXPresenter >> closeButton [

	^ SpToolbarButtonPresenter new
		  label: 'Close';
		  icon: (self iconNamed: #smallQuit);
		  help: 'Close the window';
		  action: [ self delete ];
		  yourself
]

{ #category : #'accessing - toolbar' }
SpSPDXPresenter >> copyButton [

	^ SpToolbarButtonPresenter new
		  label: 'Copy';
		  icon: (self iconNamed: #smallCopy);
		  help: 'Copy license text';
		  action: [ self copyLicenseTextAction ];
		  disable;
		  yourself
]

{ #category : #callbacks }
SpSPDXPresenter >> copyLicenseTextAction [

	Clipboard clipboardText: self selectedLicenseText.
	self inform: 'Copied to clipboard'
]

{ #category : #'accessing - toolbar' }
SpSPDXPresenter >> enableToolbarActions [
	" Private - Enable button actions in the receiver's toolbar "

	#('Copy' 'Export' 'Update') do: [ : btnName | 
		(self toolbar ifNotNil: [ : t | (t itemNamed: btnName) enable ]) ]
]

{ #category : #'accessing - toolbar' }
SpSPDXPresenter >> exportButton [

	^ SpToolbarButtonPresenter new
		  label: 'Export';
		  icon: (self iconNamed: #smallExport);
		  help: 'Export license text to file';
		  action: [ self exportLicenseAction ];
		  disable;
		  yourself
]

{ #category : #callbacks }
SpSPDXPresenter >> exportLicenseAction [
	" Private - User has clicked in the Export action, ask for a file name and save "

	self selectedLicenseText 
		ifNotEmpty: [ : selectedLicense | self saveWithExtension: 'txt' ]
		ifEmpty: [ self inform: 'Please select a license' ]
	
]

{ #category : #initialization }
SpSPDXPresenter >> initialExtent [
 	" Private - See superimplementor's comment "

	^ 1200 @ 600
]

{ #category : #initialization }
SpSPDXPresenter >> initializeLicensePresenter [

	self licensePresenter: (SpSPDXLicensePresenter newApplication: self application).
	self announcer
		when: SpSPDXLicenseChanged
		send: #updateWithLicense:
		to: self licensePresenter
]

{ #category : #'accessing - table' }
SpSPDXPresenter >> initializeLicensesTable [

	licenseTable := self newTable
		beResizable;
		enableSearch;
		searchMatching: [ : licObj : pattern | self searchPatternIn: licObj pattern: pattern ];
		showColumnHeaders;
		whenSelectionChangedDo: [ : selection | 
			self enableToolbarActions.
			self announce: (SpSPDXLicenseChanged with: selection selectedItem) ].		
	self addLicenseColumns.
	licenseTable	 items: self application licenses
]

{ #category : #initialization }
SpSPDXPresenter >> initializePresenters [
	" Private - See superimplementor's comment "

	self initializeLicensesTable.
	self initializeToolbar.
	self initializeLicensePresenter.
	" self initializeFocus."
]

{ #category : #'accessing - toolbar' }
SpSPDXPresenter >> initializeToolbar [
	" Private - Initialize the toolbar buttons "

	toolbar := self newToolbar
		           	addItem: self copyButton;
		           	addItem: self exportButton;
						addItem: self updateButton;
		          	addItem: self closeButton;
		           	yourself
]

{ #category : #initialization }
SpSPDXPresenter >> initializeWindow: aWindowPresenter [
	" Private - Set aWindowPresenter window properties "

	aWindowPresenter 
		title: self title;
		initialExtent: self initialExtent;
		aboutText: self aboutSpdxLicenseSelectorText
]

{ #category : #accessing }
SpSPDXPresenter >> licensePresenter [

	^ licensePresenter
]

{ #category : #accessing }
SpSPDXPresenter >> licensePresenter: anObject [

	licensePresenter := anObject
]

{ #category : #accessing }
SpSPDXPresenter >> licenseTable [

	^ licenseTable
]

{ #category : #accessing }
SpSPDXPresenter >> licenseTable: anObject [

	licenseTable := anObject
]

{ #category : #callbacks }
SpSPDXPresenter >> saveLicense: selectedFile withExtension: anExtension [

	selectedFile asFileReference writeStreamDo: [ :str | 
		str
			nextPutAll: self selectedLicenseText;
			truncate: self selectedLicenseText size ].
	selectedFile extension = anExtension asString ifFalse: [ 
		[ selectedFile renameTo: selectedFile withoutExtension basename , '.' , anExtension asString ]
		on: FileExists
		do: [ : ex | selectedFile delete ]. ].
	^ self
]

{ #category : #callbacks }
SpSPDXPresenter >> saveWithExtension: anExtension [

	| selectedFile |
	selectedFile := FDSaveFileDialog new defaultName: ('LICENSE.', anExtension asString); openModal.
	selectedFile ifNotNil: [ 
		self 
			saveLicense: selectedFile withExtension: anExtension; 
			yourself ].

]

{ #category : #'accessing - table' }
SpSPDXPresenter >> searchPatternIn: licObj pattern: pattern [
	" Answer <true> if pattern is found in any of the searchable accessors of licObj "
	
	^ licObj 
		ifNotNil: [ 
			licObj searchableAccessors anySatisfy: [ : accessor | (licObj perform: accessor) asLowercase beginsWith: (pattern trimBoth asLowercase) ] ]
		ifNil: [ false ]
]

{ #category : #callbacks }
SpSPDXPresenter >> selectedLicenseText [
	" Answer a <String> with the currently selected license text "
	
	^ self licensePresenter licenseText text
]

{ #category : #initialization }
SpSPDXPresenter >> title [ 

	^ 'SPDX License Selector - ' , self versionString
]

{ #category : #accessing }
SpSPDXPresenter >> toolbar [

	^ toolbar
]

{ #category : #accessing }
SpSPDXPresenter >> toolbar: anObject [

	toolbar := anObject
]

{ #category : #initialization }
SpSPDXPresenter >> updateButton [

	^ SpToolbarButtonPresenter new
		  label: 'Update';
		  icon: (self iconNamed: #smallUpdate);
		  help: 'Update licenses';
		  action: [ self updateLicensesAction ];
		  disable;
		  yourself
]

{ #category : #callbacks }
SpSPDXPresenter >> updateLicensesAction [
	" Private - The user requested to update receiver's licenses. Update and reload. "
	

]

{ #category : #initialization }
SpSPDXPresenter >> versionString [

	^ '1.0'
]
