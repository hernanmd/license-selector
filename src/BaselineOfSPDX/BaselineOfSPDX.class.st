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
			self neoJson: spec.
			
			spec 
				package: 'SPDX' 		with: [ spec requires: #('NeoJSON') ];
				package: 'SPDX-Tests'	with: [ spec requires: #(SPDX) ].
			spec 
				group: 'Core' 						with: #('SPDX');
				group: 'Tests' 						with: #('SPDX' 'SPDX-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]

{ #category : #baselines }
BaselineOfSPDX >> neoJson: spec [ 

	spec 
		baseline: 'NeoJSON' 
		with: [ spec repository: 'github://svenvc/NeoJSON/repository' ].
]
