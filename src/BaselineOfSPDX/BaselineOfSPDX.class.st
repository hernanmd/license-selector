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
			spec 
				package: 'SPDX';
				package: 'SPDX-Tests'	with: [ spec requires: #(SPDX) ].
			spec 
				group: 'Core' 						with: #('SPDX');
				group: 'Tests' 						with: #('SPDX' 'SPDX-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]
