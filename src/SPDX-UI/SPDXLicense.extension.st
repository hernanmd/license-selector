Extension { #name : #SPDXLicense }

{ #category : #'*SPDX-UI' }
SPDXLicense >> searchableAccessors [
	" Answer a <Collection> of <Symbol> representing each a receiver's searchable accessor "
	
	^ { 
		#licenseName .
		#licenseId .
		#detailsUrl .
		}
]
