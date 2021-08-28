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
		add: (SpPanedLayout newLeftToRight 
			add: #licenseTable;
			add: #licensePresenter;
			yourself);
		add: #toolbar height:  self toolbarHeight;
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
		whenSelectionChangedDo: [ : selection | self announce: (SpSPDXLicenseChanged with: selection selectedItem) ].		
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
		addItemRight: (SpToolbarButtonPresenter new
			label: 'Copy';
			icon: (self iconNamed: #smallCopy);
			help: 'Copy license text';
			action: [ 
				Clipboard clipboardText: self selectedLicenseText.
				self inform: 'Copied to clipboard' ];
			yourself);
		addItemRight: (SpToolbarButtonPresenter new
			label: 'Close';
			icon: (self iconNamed: #smallQuit);
			help: 'Close the window';
			action: [ self delete ];
			yourself);
		yourself.
]

{ #category : #initialization }
SpSPDXPresenter >> initializeWindow: aWindowPresenter [

  aWindowPresenter 
    title: self title;
    initialExtent: self initialExtent;
    whenClosedDo: [ ... ];
    whenOpenedDo: [ ...];
    whenResizingDo: [ ... ]
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

{ #category : #initialization }
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
