"
Represents an individual license, as supplied from SPDX API.

Internal Representation and Key Implementation Points.

    Instance Variables
	detailsUrl:		<Object>
	isDeprecatedLicenseId:		<Object>
	isOsiApproved:		<Object>
	licenseId:		<Object>
	name:		<Object>
	reference:		<Object>
	referenceNumber:		<Object>
	seeAlso:		<Object>


    Implementation Points
"
Class {
	#name : #SPDXLicense,
	#superclass : #Object,
	#instVars : [
		'reference',
		'detailsUrl',
		'referenceNumber',
		'isDeprecatedLicenseId',
		'seeAlso',
		'isOsiApproved',
		'name',
		'licenseDetails',
		'licenseText',
		'licenseId',
		'licenseComments'
	],
	#category : #'SPDX-Core'
}

{ #category : #accessing }
SPDXLicense class >> neoJsonMapping: mapper [

	mapper 
		for: self 
		do: [ : mapping |
			mapping mapInstVars: #(reference isDeprecatedLicenseId detailsUrl referenceNumber name licenseId seeAlso isOsiApproved ).
			mapping mapInstVar: #name to: #licenseName ]
]

{ #category : #accessing }
SPDXLicense >> detailsUrl [
	^ detailsUrl
]

{ #category : #accessing }
SPDXLicense >> detailsUrl: anObject [
	detailsUrl := anObject
]

{ #category : #accessing }
SPDXLicense >> getDetails [

	| httpClient |
	httpClient := ZnClient new
		https;
		enforceHttpSuccess: true;
		accept: ZnMimeType applicationJson;
		url: self detailsUrl.
	^ [ httpClient get ] 
		on: ZnHttpUnsuccessful
		do: [ : exception | 
			self error: exception messageText.			
			Transcript crShow: exception ]  
]

{ #category : #accessing }
SPDXLicense >> isDeprecatedLicenseId [
	^ isDeprecatedLicenseId
]

{ #category : #accessing }
SPDXLicense >> isDeprecatedLicenseId: anObject [
	isDeprecatedLicenseId := anObject
]

{ #category : #accessing }
SPDXLicense >> isOsiApproved [
	^ isOsiApproved
]

{ #category : #accessing }
SPDXLicense >> isOsiApproved: anObject [
	isOsiApproved := anObject
]

{ #category : #accessing }
SPDXLicense >> licenseComments [
	^ licenseComments
		ifNil: [ licenseComments := self licenseDetails at: 'licenseComments'  ifAbsent: [ String empty ] ]
]

{ #category : #accessing }
SPDXLicense >> licenseComments: anObject [
	licenseComments := anObject
]

{ #category : #accessing }
SPDXLicense >> licenseDetails [
	" Answer a <String> in JSON format with receiver's detail information "

	^ licenseDetails 
		ifNil: [ licenseDetails := NeoJSONReader fromString: self getDetails ]
]

{ #category : #accessing }
SPDXLicense >> licenseId [
	^ licenseId
]

{ #category : #accessing }
SPDXLicense >> licenseId: anObject [
	licenseId := anObject
]

{ #category : #accessing }
SPDXLicense >> licenseName [
	^ name
]

{ #category : #accessing }
SPDXLicense >> licenseName: anObject [
	name := anObject
]

{ #category : #accessing }
SPDXLicense >> licenseText [

	^ licenseText
		ifNil: [ licenseText := self licenseDetails at: 'licenseText' ]
]

{ #category : #accessing }
SPDXLicense >> name: anObject [
	name := anObject
]

{ #category : #accessing }
SPDXLicense >> reference [
	^ reference
]

{ #category : #accessing }
SPDXLicense >> reference: anObject [
	reference := anObject
]

{ #category : #accessing }
SPDXLicense >> referenceNumber [
	^ referenceNumber
]

{ #category : #accessing }
SPDXLicense >> referenceNumber: anObject [
	referenceNumber := anObject
]

{ #category : #accessing }
SPDXLicense >> seeAlso [
	^ seeAlso
]

{ #category : #accessing }
SPDXLicense >> seeAlso: anObject [
	seeAlso := anObject
]
