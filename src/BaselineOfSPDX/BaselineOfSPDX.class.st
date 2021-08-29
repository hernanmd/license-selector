Class {
	#name : #BaselineOfSPDX,
	#superclass : #BaselineOf,
	#category : #BaselineOfSPDX
}

{ #category : #baselines }
BaselineOfSPDX >> baseline: spec [
  <baseline>
	spec
		for: #(common)
		do: [ 
			self 
				neoJson: spec;
				commonUtils: spec;
				fileDialog: spec.
			
			spec 
				package: 'SPDX' 		with: [ spec requires: #('NeoJSON' 'CommonUtils') ];
				package: 'SPDX-UI' 	with: [ spec requires: #('SPDX' 'FileDialog') ];
				package: 'SPDX-Tests'	with: [ spec requires: #(SPDX) ].
			spec 
				group: 'Core' 						with: #('SPDX' 'SPDX-UI');
				group: 'Tests' 						with: #('SPDX' 'SPDX-Tests');
				group: 'default' 					with: #('Core') ]
]

{ #category : #baselines }
BaselineOfSPDX >> commonUtils: spec [ 

	spec 
		baseline: 'CommonUtils' 
		with: [ spec repository: 'github://hernanmd/CommonUtils/repository' ].
]

{ #category : #baselines }
BaselineOfSPDX >> fileDialog: spec [ 

	spec
		baseline: 'FileDialog'
		with: [ spec repository: 'github://Ducasse/file-dialog/repository' ].
]

{ #category : #baselines }
BaselineOfSPDX >> neoJson: spec [ 

	spec 
		baseline: 'NeoJSON' 
		with: [ spec repository: 'github://svenvc/NeoJSON/repository' ].
]
