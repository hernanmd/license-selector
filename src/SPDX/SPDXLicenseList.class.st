"
Helper object used during NeoJSON parsing of licenses. It contains a list of mapped SPDXLicense.


    Instance Variables
	licenses:		<Collection>

"
Class {
	#name : #SPDXLicenseList,
	#superclass : #Object,
	#instVars : [
		'licenses'
	],
	#category : #'SPDX-Parsing'
}

{ #category : #accessing }
SPDXLicenseList >> licenseNames [

	^ self licenses collect: #licenseName
]

{ #category : #accessing }
SPDXLicenseList >> licenses [
	^ licenses
]

{ #category : #accessing }
SPDXLicenseList >> licenses: anObject [
	licenses := anObject
]
