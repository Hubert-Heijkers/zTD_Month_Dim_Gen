﻿601,100
602,"zTD_Time_Setup_Dim_Param_DimPrefix_UnprefixedDim_ElemPrefix_Path"
562,"VIEW"
586,"zTD_Wide_Cube"
585,"zTD_Wide_Cube"
564,
565,"mpjO[ZuCA5O\wawQy00?v5KCaPbtsy;>UDPqQRq8ba?k0O`]GPYuUvq\75mFh0G?;=HkPrmGu_FUJ]AKbG\5JzI??5v]@3]Jt1`kajSgJKYc`VkA<k<y]qJ4loM>E3YrAtfz5xvHn6KZknWa9yAVjp^h3gD;Jd=HNQ5a4]Ew8kv<MZLKGvmLaOwf9cP\kJ^GoAVsK?W@"
559,1
928,0
593,
594,
595,
597,
598,
596,
800,
801,
566,0
567,","
588,"."
589,","
568,""""
570,zTD_All
571,
569,1
592,0
599,1000
560,4
pDimPrefix
pUnprefixedDim
pElemPrefix
pPath
561,4
2
2
2
2
590,4
pDimPrefix,"C_"
pUnprefixedDim,"Effective_Mth"
pElemPrefix,"E_"
pPath,"E:\Dropbox\TM1\zTD_Dev\ImportData\"
637,4
pDimPrefix,"Dimension Prefix"
pUnprefixedDim,"Unprefixed Dim Name"
pElemPrefix,"Element Prefix"
pPath,"Folder Path relative to the Server where the CSV files were generated by the spreadsheet."
577,10
Hier
Top
L1
L2
L3
L4
L5
NVALUE
SVALUE
VALUE_IS_STRING
578,10
2
2
2
2
2
2
2
1
2
1
579,10
1
2
3
4
5
6
7
0
0
0
580,10
0
0
0
0
0
0
0
0
0
0
581,10
0
0
0
0
0
0
0
0
0
0
582,21
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
IgnoredInputVarName=zTD_D8VarType=32ColType=1165
IgnoredInputVarName=zTD_D9VarType=32ColType=1165
IgnoredInputVarName=zTD_D10VarType=32ColType=1165
IgnoredInputVarName=zTD_D11VarType=32ColType=1165
IgnoredInputVarName=zTD_D12VarType=32ColType=1165
IgnoredInputVarName=zTD_D13VarType=32ColType=1165
IgnoredInputVarName=zTD_D14VarType=32ColType=1165
IgnoredInputVarName=zTD_D15VarType=32ColType=1165
IgnoredInputVarName=zTD_D16VarType=32ColType=1165
IgnoredInputVarName=zTD_D17VarType=32ColType=1165
IgnoredInputVarName=zTD_D18VarType=32ColType=1165
IgnoredInputVarName=zTD_D19VarType=32ColType=1165
IgnoredInputVarName=zTD_D20VarType=32ColType=1165
IgnoredInputVarName=ValueVarType=33ColType=1165
603,0
572,219

#****Begin: Generated Statements***
#****End: Generated Statements****

vThisPro = 'zTD_Time_Setup_Dim_Param_DimPrefix_UnprefixedDim_ElemPrefix_Path' ; 

# Copyright Success Cubed Ltd 2008-2020

# GNU License

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.

# ###############################################

# Purpose 

# This does basic setup of the Time Dim 

# It reads in information from the Hier file 

# It creates each of the Named Hierarchies if they don't already exist
# Hierarchies are created for each of the different time types in
# combination with a hierarchy for the Fin Yr beginning in January
# ie the Calendar Month year
# and for each selected Fin Yr start period that is used by the organisation.

# It populates the }DimensionProperties cube
# as these dimensions should not be sorted 
# The sort order is determined by the input order

# It populates the }HierarchyProperties cube
# to name the levels and the default element (which is the top element)

# It creates subsets for
# Default (Top Element)
# Base base level elements
# Hier full hierarchy
# Consolidations - consolidated elements
# It creates e_ prefixed versions of these with the CalMthName Alias
# It creates z_ prefixed versions of these with no alias

# It calls a sub process to read information from Fin Yr file

# The sub process 

# creates an alias for each Fin Year that was selected on the spreadsheet

# For each Time Type and Fin Yr combination it
 
# It populates the }DimensionProperties cube
# as these dimension hierarchies should not be sorted 
# The sort order is determined by the input order

# It populates the }HierarchyProperties cube
# to name the levels and the default element (which is the top element)

# It creates subsets for
# Default (Top Element)
# Base base level elements
# Hier full hierarchy
# Consolidations - consolidated elements
# It creates e_ prefixed versions of these with the CalMthName Alias
# It creates z_ prefixed versions of these with no alias

# The information from the two files combined is used to
# set up the named hierarchies


# It also creates standard subsets on each hierarchy

# NON-STANDARD CUT DOWN ERROR HANDLING
# This process does not use the full set of zTD
# process initialisation and error handling routines

# ###############################################

# Session Variables

NumericSessionVariable('svError') ;

svError = 0 ;

# ###############################################

# Standard Variables

vDataRecCount = 0 ; 
vMetaDataRecCount = 0 ; 

# ######################################################

# Constants

gvInfoDimCube = 'zTD_Info_Dim' ; 
gvMirrorDimensionDim = 'zTD_Control_Dimensions' ;

vDimPropCube = '}DimensionProperties' ; 
vHierPropCube = '}HierarchyProperties' ; 

vAlias = 'CalMthName' ; 

# ######################################################

# Validate Parameters

vDimPrefix = pDimPrefix ;
vUnprefixedDim = pUnprefixedDim ;
vElemPrefix = pElemPrefix ;

IF( vUnprefixedDim  @= ''  ) ;
  vMsg = 'The Unprefixed Dim Name cannot be blank' ;
  svError = 1 ;
  ItemReject( vMsg ) ;
ENDIF ;

# #################################

vPath = pPath ;

IF( vPath @= '' ) ;
  svError = 1 ;
  vMsg = 'Path cannot be blank' ; 
  ItemReject( vMsg ) ;
ENDIF ;

# ##########################################################

vDim = vDimPrefix | vUnprefixedDim ;

# ##########################################################

# Create Dimension if it doesn't already exist

IF( DimensionExists( vDim ) = 0 ) ; 
  DimensionCreate( vDim ) ;
ENDIF ;

# ##########################################################

# If using full zTD

IF( CubeExists( 'zTD_Control_Dim_Mirror' ) = 1 ) ;

  # Update Control Dim Mirrror for Dimensions

  vPro = 'zTD_Upd_Dim_Control_Mirror_Param_Dim' ;
  vRet = ExecuteProcess( vPro , 
                         'pDim' , gvMirrorDimensionDim
                       ) ;
  IF( vRet <> ProcessExitNormal() ) ;
    vMsg =  'Error running process ' | vPro | ' for Dim zTD_Control_Dimensions' | gvMirrorDimensionDim | ' to add ' | vDim ; 
    svError = 1 ;
    ItemReject( vMsg ) ;
  ENDIF ;
ENDIF ;

# ##########################################################

IF( CubeExists( gvInfoDimCube ) = 1 ) ;

  # Put the basic info into the zTD_Info_Dim cube

  CellPutS( vDimPrefix , gvInfoDimCube , vDim , 'Dim Prefix' ) ;

  CellPutS( vElemPrefix ,  gvInfoDimCube , vDim , 'Elem Prefix' ) ;

  CellPutS( 'Time' ,  gvInfoDimCube , vDim , 'Dim Type Override' ) ;

ENDIF ;

# ##########################################################

# Regardless of which Fin Yrs were chosen there will always be a 
# Calendar Month Name Alias

AttrInsert( vDim , '' , 'CalMthName' , 'A' ) ;

# ##########################################################

# Make up the full Path to the File and
# check that it exists

vFile = vDim | '_Hier.csv' ; 

vPathFile = vPath | vFile ;

IF( FileExists( vPathFile ) = 0 ) ;
  svError = 1 ;
  vMsg = 'Path File ' | vPathFile | ' does not exist. Remember that the path must be relative to the server, not the client.' ; 
  ItemReject( vMsg ) ;
ENDIF ;

# #################################

# Change Data Source to path file

DatasourceNameForServer= vPathFile ;

DataSourceType = 'CHARACTERDELIMITED' ;
DatasourceASCIIDelimiter = ',' ;
DatasourceASCIIDecimalSeparator = '.' ;
DatasourceASCIIThousandSeparator = ',' ;
DatasourceASCIIQuoteCharacter = '"' ;
DatasourceASCIIHeaderRecords = 1 ;

# #################################


573,47

#****Begin: Generated Statements***
#****End: Generated Statements****

# NON-STANDARD CUT DOWN ERROR HANDLING

# SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

# M E T A D A T A    T A B   S T A R T

IF( svError = 1 ) ;
  ProcessBreak ;
ENDIF ;

vMetaDataRecCount = vMetaDataRecCount + 1 ;

# SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

# #################################################

vHier = Hier ;

vTop = Top ;

# For MetaData , avoid trying to create the default classic hier or the leaves hier
# as the default classic hier was created when the dim was created and
# the leaves hier is updated automatically.

IF( vHier @= vDim ) ;
   # For the default classic hier we just need to ensure that
  # the top element is inserted as a consol
  DimensionElementInsert( vDim , '' , vTop , 'C' ) ;
  ItemSkip ;
ENDIF ;

IF( vHier @= 'Leaves' ) ;
  ItemSkip ;
ENDIF ;

# If a Named Hier does not already exist then create it

IF( HierarchyExists( vDim , vHier ) = 0 ) ;
  HierarchyCreate( vDim , vHier ) ;
  HierarchyTopElementInsert( vDim , vHier, '' , vTop ) ;
ENDIF ;

# #################################################
574,245

#****Begin: Generated Statements***
#****End: Generated Statements****

# NON-STANDARD CUT DOWN ERROR HANDLING

# SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

# D A T A    T A B   S T A R T

IF( svError = 1 ) ;
  ProcessBreak ;
ENDIF ;

vDataRecCount = vDataRecCount + 1 ;

# SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

# #################################################

vHier = Hier ;

vTop = Top ;

vL1 = L1 ;
vL2 = L2 ;
vL3 = L3 ;
vL4 = L4 ;
vL5 = L5 ;

# ##################################################

# Make up the Dim:Hier Name

vDimHier = vDim | ':' | vHier ;

# ##################################################

# Don't put any sorting as we want the sort out to come from the file
# so that elements are created in the right order.

IF( vHier @= vDim ) ;

  CellPutS( ' ', vDimPropCube, vDim, 'SORTCOMPONENTSSENSE' ) ;
  CellPutS( ' ', vDimPropCube, vDim, 'SORTELEMENTSSENSE') ;

  CellPutS( 'BYINPUT', vDimPropCube, vDim, 'SORTCOMPONENTSTYPE') ;
  CellPutS( 'BYINPUT', vDimPropCube, vDim, 'SORTELEMENTSTYPE') ;

ELSE ;

  CellPutS( ' ', vDimPropCube, vDimHier, 'SORTCOMPONENTSSENSE' ) ;
  CellPutS( ' ', vDimPropCube, vDimHier, 'SORTELEMENTSSENSE') ;

  CellPutS( 'BYINPUT', vDimPropCube, vDimHier, 'SORTCOMPONENTSTYPE') ;
  CellPutS( 'BYINPUT', vDimPropCube, vDimHier, 'SORTELEMENTSTYPE') ;

ENDIF ;

# ##################################################

# Put the info in to the Hierarchy Properties cube

# The Default Member of the hierarchy will be its Top element

IF( vHier @= vDim ) ;
  IF( CellIsUpdateable( vHierPropCube , vDim , 'Hierarchy0' , 'defaultMember' )  = 1 ) ; 
    CellPutS( vTop , vHierPropCube , vDim , 'Hierarchy0' , 'defaultMember' ) ; 
  ENDIF ;
ELSE; 
  CellPutS( vTop , vHierPropCube , vDimHier , 'Hierarchy0' , 'defaultMember' ) ; 
ENDIF ;

# If there is no name for the level it will just be blank on the file
# so we don't need to bother checking how many levels the
# hierarchy has

# No point doing this for the classic hier as level names
# are not meaningful in a classic hier with alternate hierarchies
# that have different number of levels 

IF( vDim @<> vHier ) ;

  CellPutS( vL1 , vHierPropCube , vDimHier , 'Hierarchy0' , 'level001' ) ; 
  CellPutS( vL2 , vHierPropCube , vDimHier , 'Hierarchy0' , 'level002' ) ; 
  CellPutS( vL3 , vHierPropCube , vDimHier , 'Hierarchy0' , 'level003' ) ; 
  CellPutS( vL4 , vHierPropCube , vDimHier , 'Hierarchy0' , 'level004' ) ; 
  CellPutS( vL5 , vHierPropCube , vDimHier , 'Hierarchy0' , 'level005' ) ; 

ENDIF ;

# #################################################

# Setup subsets

vTargetDim = vDim ;

ve_Alias = 'CalMthName' ;

vDim = vTargetDim ;
vHierTop = vTop ;

# ##

vSubSuffix = 'Default' ;

# First time through we create a Default subset with no prefix
# so the hier has a default subset
# This is the same as the e_ prefixxed subset

vSub = vSubSuffix  ; 

IF( HierarchySubsetExists( vTargetDim,  vHier, vSub ) = 1 ) ;
  HierarchySubsetDeleteAllElements( vDim , vHier , vSub ) ;
ELSE ;
  HierarchySubsetCreate( vDim , vHier , vSub ) ;
ENDIF ;
HierarchySubsetElementInsert( vDim , vHier , vSub , vHierTop , 1 );
IF( vHier @= vDim ) ;
  SubsetAliasSet( vDim , vSub, vAlias ) ;
ELSE ;
  HierarchySubsetAliasSet( vDim , vHier, vSub, vAlias ) ;
ENDIF ;

# ##

vSubSuffix = 'Default' ;

vSub = 'e_' | vSubSuffix  ; 

IF( HierarchySubsetExists( vTargetDim,  vHier, vSub ) = 1 ) ;
  HierarchySubsetDeleteAllElements( vDim , vHier , vSub ) ;
ELSE ;
  HierarchySubsetCreate( vDim , vHier , vSub ) ;
ENDIF ;
HierarchySubsetElementInsert( vDim , vHier , vSub , vHierTop , 1 );
IF( vHier @= vDim ) ;
  SubsetAliasSet( vDim , vSub, vAlias ) ;
ELSE ;
  HierarchySubsetAliasSet( vDim , vHier, vSub, vAlias ) ;
ENDIF ;

vSub = 'z_' | vSubSuffix  ; 

IF( HierarchySubsetExists( vTargetDim,  vHier, vSub ) = 1 ) ;
  HierarchySubsetDeleteAllElements( vDim , vHier , vSub ) ;
ELSE ;
  HierarchySubsetCreate( vDim , vHier , vSub ) ;
ENDIF ;
HierarchySubsetElementInsert( vDim , vHier , vSub , vHierTop , 1 );

# ##

vSubSuffix = 'Hier' ;

vMDX = '{HIERARCHIZE(  {TM1SUBSETALL([' | vDim | '].[' | vHier | '])}  )} ' ;

vSub = 'e_' | vSubSuffix  ; 

IF( HierarchySubsetExists( vTargetDim,  vHier, vSub ) = 0 ) ;
  HierarchySubsetCreate( vDim , vHier , vSub ) ;
ENDIF ;
HierarchySubsetMDXSet( vDim , vHier , vSub , vMDX );
IF( vHier @= vDim ) ;
  SubsetAliasSet( vDim , vSub, vAlias ) ;
ELSE ;
  HierarchySubsetAliasSet( vDim , vHier, vSub, vAlias ) ;
ENDIF ;

vSub = 'z_' | vSubSuffix  ; 

IF( HierarchySubsetExists( vTargetDim,  vHier, vSub ) = 0 ) ;
  HierarchySubsetCreate( vDim , vHier , vSub ) ;
ENDIF ;
HierarchySubsetMDXSet( vDim , vHier , vSub , vMDX );

# ##

vSubSuffix = 'Base' ;

vMDX = '{ TM1SORT( { TM1FILTERBYLEVEL(  {TM1SUBSETALL( [' | vDim | '].[' | vHier | '] ) } , 0 ) } , ASC )  } ' ;

vSub = 'e_' | vSubSuffix  ; 

vSub = 'e_' | vSubSuffix  ; 

IF( HierarchySubsetExists( vTargetDim,  vHier, vSub ) = 0 ) ;
  HierarchySubsetCreate( vDim , vHier , vSub ) ;
ENDIF ;
HierarchySubsetMDXSet( vDim , vHier , vSub , vMDX );
IF( vHier @= vDim ) ;
  SubsetAliasSet( vDim , vSub, vAlias ) ;
ELSE ;
  HierarchySubsetAliasSet( vDim , vHier, vSub, vAlias ) ;
ENDIF ;

vSub = 'z_' | vSubSuffix  ; 

IF( HierarchySubsetExists( vTargetDim,  vHier, vSub ) = 0 ) ;
  HierarchySubsetCreate( vDim , vHier , vSub ) ;
ENDIF ;
HierarchySubsetMDXSet( vDim , vHier , vSub , vMDX );

# ##

vSubSuffix = 'Consolidations' ;

vMDX =     '{EXCEPT({TM1SUBSETALL( [' | vDim | '].[' | vHier | '] )},{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | vDim | '].[' | vHier | '] )}, 0)} ) }' ;

vSub = 'e_' | vSubSuffix  ; 

IF( HierarchySubsetExists( vTargetDim,  vHier, vSub ) = 0 ) ;
  HierarchySubsetCreate( vDim , vHier , vSub ) ;
ENDIF ;
HierarchySubsetMDXSet( vDim , vHier , vSub , vMDX );
IF( vHier @= vDim ) ;
  SubsetAliasSet( vDim , vSub, vAlias ) ;
ELSE ;
  HierarchySubsetAliasSet( vDim , vHier, vSub, vAlias ) ;
ENDIF ;

vSub = 'z_' | vSubSuffix  ; 

IF( HierarchySubsetExists( vTargetDim,  vHier, vSub ) = 0 ) ;
  HierarchySubsetCreate( vDim , vHier , vSub ) ;
ENDIF ;
HierarchySubsetMDXSet( vDim , vHier , vSub , vMDX );

# ######################################################################

# Setup Fin Yr Specific Aliases and Subsets for each FinYr in use

vRet = ExecuteProcess( 'zTD_Time_Setup_Dim_Aux_Add_FinYr_Aliases_n_Subs_Param_Dim_Hier_HierTop_Path' ,
                                            'pDim' , vDim ,
                                            'pHier' , vHier , 
                                            'pHierTop' , vTop,
                                            'pPath' , vPath  ) ;
IF( vRet <> ProcessExitNormal() ) ;
  vMsg = 'Error in process to set up Fin Year Aliases on Dim ' | vDim | ' Hier ' | vHier ;
  svError = 1 ;
  ItemReject( vMsg ) ;
ENDIF ;

# ######################################################################

575,39

#****Begin: Generated Statements***
#****End: Generated Statements****

# NON-STANDARD CUT DOWN ERROR HANDLING

# SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

# EPILOG START  (after any CubeSetLogChanges)

# ##################################################

# Trap for rejects due to eg inability to convert a string to number 
# or some other such file formatting issue.

vErrorFile = GetProcessErrorFileName() ;

IF( vErrorFile @<> '' & svError = 0 ) ;
  svError = 1 ;
  vMsg = 'One or more lines were rejected, ' | 
          'possibly due to formatting issues in the source data. ' | 
           'Please check ' | vErrorFile | '  for more information. ' ; 
  ItemReject( vMsg ) ;
ENDIF ;

IF( svError = 1 ) ;

  # Raise an error

  ProcessQuit ;

ENDIF ;

# ##################################################

# SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS



576,CubeAction=1511DataAction=1503CubeLogChanges=0
930,0
638,1
804,0
1217,0
900,
901,
902,
938,0
937,
936,
935,
934,
932,0
933,0
903,
906,
929,
907,
908,
904,0
905,0
909,0
911,
912,
913,
914,
915,
916,
917,0
918,1
919,0
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""