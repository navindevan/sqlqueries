CREATE pro [tmp].[ABC113]  
 
 @META_LINEAGE_ID INT,  
 @META_LOAD_DTTM DATETIME,  
 @Insert_RecCount INT OUTPUT,  
 @Update_RecCount INT OUTPUT,  
 @Source_RecCount INT OUTPUT  
AS  
BEGIN  
  
 DECLARE @vMETA_LINEAGE_ID INT  
 DECLARE @vMETA_LOAD_DTTM DATETIME  
 DECLARE @vINS_RecCount INT  
 DECLARE @vUPD_RecCount INT  
   
 SET @vMETA_LINEAGE_ID  = @META_LINEAGE_ID  
 SET @vMETA_LOAD_DTTM = @META_LOAD_DTTM  
  
DECLARE @tableRecCount TABLE (MergeAction VARCHAR(20), InsertedID_Deployment_Id INT, UpdatedID_Deployment_Id INT)  
   
DECLARE @vSRC_RecCount INT  
SET @vSRC_RecCount = (SELECT COUNT(*) FROM [stg].[vw_SMR_SLA_Scorecard])  
  
MERGE [int].[SMR_SLA_Scorecard] tgt  
USING (  
  SELECT [Deployment_ID]  
     ,[SLA_Category]  
     ,[Period]  
     ,[Application_Deployment]  
     ,[Meeting_Service_Level_RAG]  
     ,[OP_Mean_Clean_Days_Target]  
     ,[OP_Mean_Clean_Days_Actual]  
     ,[OP_Mean_Clean_Days_RAG]  
     ,[OP_Mean_Clean_Days_AO]  
     ,[OP_Availability_Target]  
     ,[OP_Availability_Actual]  
     ,[OP_Availability_RAG]  
     ,[OP_Availability_AO]  
     ,[IM_Restoration_Priority12_Percentage]  
     ,[IM_Restoration_Priority12_RAG]  
     ,[IM_Restoration_Priority12_Meeting_SLA]  
     ,[IM_Priority12_No_of_Tickets]  
     ,[IM_Restoration_Priority34_Percentage]  
     ,[IM_Restoration_Priority34_RAG]  
     ,[IM_Restoration_Priority34_Meeting_SLA]  
     ,[IM_Priority34_No_of_Tickets]  
     ,[EUE_FCR_Target]  
     ,[EUE_FCR_Actual]  
     ,[EUE_FCR_RAG]  
     ,[EUE_FCR_Met]  
     ,[EUE_No_of_Tickets]  
     ,[CRM_Successfull_Changes_Percentage]  
     ,[CRM_Successfull_Changes_RAG]  
     ,[CRM_Successfull_Changes_Count]  
     ,[CRM_No_of_Changes]  
     ,[CRM_Releases_Delivered_OnSchedule_Percentage]  
     ,[CRM_Releases_Delivered_OnSchedule_RAG]  
     ,[CRM_Releases_Delivered_OnSchedule_Count]  
     ,[CRM_No_of_Releases]  
  FROM [stg].[vw_SMR_SLA_Scorecard]) AS src (  
    [Deployment_ID]  
     ,[SLA_Category]  
     ,[Period]  
     ,[Application_Deployment]  
     ,[Meeting_Service_Level_RAG]  
     ,[OP_Mean_Clean_Days_Target]  
     ,[OP_Mean_Clean_Days_Actual]  
     ,[OP_Mean_Clean_Days_RAG]  
     ,[OP_Mean_Clean_Days_AO]  
     ,[OP_Availability_Target]  
     ,[OP_Availability_Actual]  
     ,[OP_Availability_RAG]  
     ,[OP_Availability_AO]  
     ,[IM_Restoration_Priority12_Percentage]  
     ,[IM_Restoration_Priority12_RAG]  
     ,[IM_Restoration_Priority12_Meeting_SLA]  
     ,[IM_Priority12_No_of_Tickets]  
     ,[IM_Restoration_Priority34_Percentage]  
     ,[IM_Restoration_Priority34_RAG]  
     ,[IM_Restoration_Priority34_Meeting_SLA]  
     ,[IM_Priority34_No_of_Tickets]  
     ,[EUE_FCR_Target]  
     ,[EUE_FCR_Actual]  
     ,[EUE_FCR_RAG]  
     ,[EUE_FCR_Met]  
     ,[EUE_No_of_Tickets]  
     ,[CRM_Successfull_Changes_Percentage]  
     ,[CRM_Successfull_Changes_RAG]  
     ,[CRM_Successfull_Changes_Count]  
     ,[CRM_No_of_Changes]  
     ,[CRM_Releases_Delivered_OnSchedule_Percentage]  
     ,[CRM_Releases_Delivered_OnSchedule_RAG]  
     ,[CRM_Releases_Delivered_OnSchedule_Count]  
     ,[CRM_No_of_Releases]  
  )  
ON   
(src.[Deployment_ID] = tgt.[Deployment_ID] AND src.[SLA_Category] = tgt.[SLA_Category] AND  src.[Period] = tgt.[Period])   
  
WHEN MATCHED THEN   
UPDATE SET   
 tgt.[Application_Deployment] =  src.[Application_Deployment]  
,tgt.[Meeting_Service_Level_RAG] =  src.[Meeting_Service_Level_RAG]  
,tgt.[OP_Mean_Clean_Days_Target] =  src.[OP_Mean_Clean_Days_Target]  
,tgt.[OP_Mean_Clean_Days_Actual] =  src.[OP_Mean_Clean_Days_Actual]  
,tgt.[OP_Mean_Clean_Days_RAG] =  src.[OP_Mean_Clean_Days_RAG]  
,tgt.[OP_Mean_Clean_Days_AO] =  src.[OP_Mean_Clean_Days_AO]  
,tgt.[OP_Availability_Target] =  src.[OP_Availability_Target]  
,tgt.[OP_Availability_Actual] =  src.[OP_Availability_Actual]  
,tgt.[OP_Availability_RAG] =  src.[OP_Availability_RAG]  
,tgt.[OP_Availability_AO] =  src.[OP_Availability_AO]  
,tgt.[IM_Restoration_Priority12_Percentage] =  src.[IM_Restoration_Priority12_Percentage]  
,tgt.[IM_Restoration_Priority12_RAG] =  src.[IM_Restoration_Priority12_RAG]  
,tgt.[IM_Restoration_Priority12_Meeting_SLA] =  src.[IM_Restoration_Priority12_Meeting_SLA]  
,tgt.[IM_Priority12_No_of_Tickets] =  src.[IM_Priority12_No_of_Tickets]  
,tgt.[IM_Restoration_Priority34_Percentage] =  src.[IM_Restoration_Priority34_Percentage]  
,tgt.[IM_Restoration_Priority34_RAG] =  src.[IM_Restoration_Priority34_RAG]  
,tgt.[IM_Restoration_Priority34_Meeting_SLA] =  src.[IM_Restoration_Priority34_Meeting_SLA]  
,tgt.[IM_Priority34_No_of_Tickets] =  src.[IM_Priority34_No_of_Tickets]  
,tgt.[EUE_FCR_Target] =  src.[EUE_FCR_Target]  
,tgt.[EUE_FCR_Actual] =  src.[EUE_FCR_Actual]  
,tgt.[EUE_FCR_RAG] =  src.[EUE_FCR_RAG]  
,tgt.[EUE_FCR_Met] =  src.[EUE_FCR_Met]  
,tgt.[EUE_No_of_Tickets] =  src.[EUE_No_of_Tickets]  
,tgt.[CRM_Successfull_Changes_Percentage] =  src.[CRM_Successfull_Changes_Percentage]  
,tgt.[CRM_Successfull_Changes_RAG] =  src.[CRM_Successfull_Changes_RAG]  
,tgt.[CRM_Successfull_Changes_Count] =  src.[CRM_Successfull_Changes_Count]  
,tgt.[CRM_No_of_Changes] =  src.[CRM_No_of_Changes]  
,tgt.[CRM_Releases_Delivered_OnSchedule_Percentage] =  src.[CRM_Releases_Delivered_OnSchedule_Percentage]  
,tgt.[CRM_Releases_Delivered_OnSchedule_RAG] =  src.[CRM_Releases_Delivered_OnSchedule_RAG]  
,tgt.[CRM_Releases_Delivered_OnSchedule_Count] =  src.[CRM_Releases_Delivered_OnSchedule_Count]  
,tgt.[CRM_No_of_Releases] =  src.[CRM_No_of_Releases]  
,tgt.[_META_LOAD_DTTM] = @vMETA_LOAD_DTTM  
,tgt.[_META_UPDATE_DTTM] = GETDATE()  
   
WHEN NOT MATCHED THEN  
INSERT (  
 [Deployment_ID]  
,[SLA_Category]  
,[Period]  
,[Application_Deployment]  
,[Meeting_Service_Level_RAG]  
,[OP_Mean_Clean_Days_Target]  
,[OP_Mean_Clean_Days_Actual]  
,[OP_Mean_Clean_Days_RAG]  
,[OP_Mean_Clean_Days_AO]  
,[OP_Availability_Target]  
,[OP_Availability_Actual]  
,[OP_Availability_RAG]  
,[OP_Availability_AO]  
,[IM_Restoration_Priority12_Percentage]  
,[IM_Restoration_Priority12_RAG]  
,[IM_Restoration_Priority12_Meeting_SLA]  
,[IM_Priority12_No_of_Tickets]  
,[IM_Restoration_Priority34_Percentage]  
,[IM_Restoration_Priority34_RAG]  
,[IM_Restoration_Priority34_Meeting_SLA]  
,[IM_Priority34_No_of_Tickets]  
,[EUE_FCR_Target]  
,[EUE_FCR_Actual]  
,[EUE_FCR_RAG]  
,[EUE_FCR_Met]  
,[EUE_No_of_Tickets]  
,[CRM_Successfull_Changes_Percentage]  
,[CRM_Successfull_Changes_RAG]  
,[CRM_Successfull_Changes_Count]  
,[CRM_No_of_Changes]  
,[CRM_Releases_Delivered_OnSchedule_Percentage]  
,[CRM_Releases_Delivered_OnSchedule_RAG]  
,[CRM_Releases_Delivered_OnSchedule_Count]  
,[CRM_No_of_Releases]  
,[_META_LINEAGE_ID],[_META_LOAD_DTTM],[_META_INSERT_DTTM])  
VALUES (  
 src.[Deployment_ID]  
,src.[SLA_Category]  
,src.[Period]  
,src.[Application_Deployment]  
,src.[Meeting_Service_Level_RAG]  
,src.[OP_Mean_Clean_Days_Target]  
,src.[OP_Mean_Clean_Days_Actual]  
,src.[OP_Mean_Clean_Days_RAG]  
,src.[OP_Mean_Clean_Days_AO]  
,src.[OP_Availability_Target]  
,src.[OP_Availability_Actual]  
,src.[OP_Availability_RAG]  
,src.[OP_Availability_AO]  
,src.[IM_Restoration_Priority12_Percentage]  
,src.[IM_Restoration_Priority12_RAG]  
,src.[IM_Restoration_Priority12_Meeting_SLA]  
,src.[IM_Priority12_No_of_Tickets]  
,src.[IM_Restoration_Priority34_Percentage]  
,src.[IM_Restoration_Priority34_RAG]  
,src.[IM_Restoration_Priority34_Meeting_SLA]  
,src.[IM_Priority34_No_of_Tickets]  
,src.[EUE_FCR_Target]  
,src.[EUE_FCR_Actual]  
,src.[EUE_FCR_RAG]  
,src.[EUE_FCR_Met]  
,src.[EUE_No_of_Tickets]  
,src.[CRM_Successfull_Changes_Percentage]  
,src.[CRM_Successfull_Changes_RAG]  
,src.[CRM_Successfull_Changes_Count]  
,src.[CRM_No_of_Changes]  
,src.[CRM_Releases_Delivered_OnSchedule_Percentage]  
,src.[CRM_Releases_Delivered_OnSchedule_RAG]  
,src.[CRM_Releases_Delivered_OnSchedule_Count]  
,src.[CRM_No_of_Releases]  
,@vMETA_LINEAGE_ID,@vMETA_LOAD_DTTM,GETDATE() )  
  
OUTPUT  
      $action AS MergeAction,  
      Inserted.[Deployment_ID] AS InsertedID_Deployment_Id,  
      Deleted.[Deployment_ID] AS UpdatedID_Deployment_Id INTO @tableRecCount;  
  
UPDATE [int].[SMR_SLA_Scorecard]  
SET _META_DELETE_DTTM = GETDATE()  
,[_META_LOAD_DTTM] = @vMETA_LOAD_DTTM  
FROM   
  [int].[SMR_SLA_Scorecard]  
WHERE   
  [int].[SMR_SLA_Scorecard].[_META_DELETE_DTTM] IS NULL AND   
  [int].[SMR_SLA_Scorecard].[Deployment_ID] IS NOT NULL AND   
  [int].[SMR_SLA_Scorecard].[Deployment_ID] NOT IN  
   (SELECT [Deployment_ID] FROM [stg].[vw_SMR_SLA_Scorecard]);  
  
  
SET  @vINS_RecCount = (SELECT COUNT(InsertedID_Deployment_Id) FROM @tableRecCount WHERE MergeAction = 'INSERT')  
SET  @vUPD_RecCount = (SELECT COUNT(UpdatedID_Deployment_Id) FROM @tableRecCount WHERE MergeAction = 'UPDATE')  
  
SET @Insert_RecCount = @vINS_RecCount  
SET @Update_RecCount = @vUPD_RecCount  
SET @Source_RecCount = @vSRC_RecCount  
SELECT @Insert_RecCount AS vInsert_RecCount,@Update_RecCount AS vUpdate_RecCount,@Source_RecCount AS vSource_RecCount  