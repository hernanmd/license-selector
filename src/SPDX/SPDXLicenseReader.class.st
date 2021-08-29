"
This class only provides a couple of helper class methods to retrieve and parse licenses in JSON format. It uses the NeoJSON library.

Usage example:

```
SPDXLicenseReader fetchLicenseJSON.
```

"
Class {
	#name : #SPDXLicenseReader,
	#superclass : #Object,
	#category : #'SPDX-Parsing'
}

{ #category : #accessing }
SPDXLicenseReader class >> fetchLicenseJSON [

	^ [ [ :bar | 

		bar title: 'Downloading Licenses...'.
		[ self httpRequest get ]
		on: HTTPProgress
		do: [ :progress | 
			progress isEmpty ifFalse: [ bar current: progress percentage ].
			progress resume ] ] asJob run 
		]
		on: ZnHttpUnsuccessful
		do: [ :exception | self error: exception messageText ]
]

{ #category : #accessing }
SPDXLicenseReader class >> httpRequest [

	^ ZnClient new
		https;
		signalProgress: true;
		enforceHttpSuccess: true;
		accept: ZnMimeType applicationJson;
		url: self licensesEndpointUrl;
		contentReader: self neoJsonReaderBlock.
]

{ #category : #accessing }
SPDXLicenseReader class >> licensesEndpointUrl [

	^ 'https://spdx.org/licenses/licenses.json'
]

{ #category : #accessing }
SPDXLicenseReader class >> neoJsonReaderBlock [

	^ [ : entity | 

		[	|reader|
			reader := (NeoJSONReader on: entity readStream).
			reader for: SPDXObject do: 
			[ : m | 
				m mapInstVars: #(licenseListVersion releaseDate).
				(m mapInstVar: #licenses) valueSchema: SPDXLicenseList.
			].
			reader for: SPDXLicenseList customDo: [ : mapping | mapping listOfElementSchema: SPDXLicense ].
			reader nextAs: SPDXObject
		] 
		on: NeoJSONParseError 
		do: [ : err |
			self inform: 'Parse error while reading JSON data...'.
			(NeoJSONReader fromString: entity contents) inspect ]
 		]
]
