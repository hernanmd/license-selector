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

{ #category : #callbacks }
SpSPDXPresenter >> copyLicenseTextAction [

	Clipboard clipboardText: self selectedLicenseText.
	self inform: 'Copied to clipboard'
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

{ #category : #initialization }
SpSPDXPresenter >> initializeLicensesTable [

	licenseTable := self newTable
		beResizable;
		showColumnHeaders;
		whenSelectionChangedDo: [ : selection | 
			(self toolbar ifNotNil: [ : t | (t itemNamed: 'Copy') enable ]).
			(self toolbar ifNotNil: [ : t | (t itemNamed: 'Export') enable ]).
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

{ #category : #initialization }
SpSPDXPresenter >> initializeToolbar [
	" self initializeFocus."

	toolbar := self newToolbar
		addItem: (SpToolbarButtonPresenter new
			label: 'Copy';
			icon: (self iconNamed: #smallCopy);
			help: 'Copy license text';
			action: [ self copyLicenseTextAction ];
			disable;
			yourself);
		addItem: (SpToolbarButtonPresenter new
			label: 'Export';
			icon: (self iconNamed: #smallExport);
			help: 'Export license text to file';
			action: [ self exportLicenseAction ];
			disable;
			yourself);
		addItem: (SpToolbarButtonPresenter new
			label: 'Close';
			icon: (self iconNamed: #smallQuit);
			help: 'Close the window';
			action: [ self delete ];
			yourself);
		yourself.
]

{ #category : #initialization }
SpSPDXPresenter >> initializeWindow: aWindowPresenter [
	" Private - Set aWindowPresenter window properties "

	aWindowPresenter 
		title: self title;
		initialExtent: self initialExtent
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
	selectedFile ifNotNil: [ ^ self saveLicense: selectedFile withExtension: anExtension; yourself ].
	^ nil
]

{ #category : #callbacks }
SpSPDXPresenter >> selectedLicenseText [
	" Answer a <String> with the currently selected license text "
	
	^ self licensePresenter licenseText text
]

{ #category : #initialization }
SpSPDXPresenter >> title [ 

	^ 'SPDX License Selector'
]

{ #category : #accessing }
SpSPDXPresenter >> toolbar [

	^ toolbar
]

{ #category : #accessing }
SpSPDXPresenter >> toolbar: anObject [

	toolbar := anObject
]
