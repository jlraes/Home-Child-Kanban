declare module "@salesforce/apex/HomeChildKanbanCls.saveConfig" {
  export default function saveConfig(param: {obj: any}): Promise<any>;
}
declare module "@salesforce/apex/HomeChildKanbanCls.getObjs" {
  export default function getObjs(): Promise<any>;
}
declare module "@salesforce/apex/HomeChildKanbanCls.getObjChilds" {
  export default function getObjChilds(param: {objName: any}): Promise<any>;
}
declare module "@salesforce/apex/HomeChildKanbanCls.getObjFlds" {
  export default function getObjFlds(param: {objName: any}): Promise<any>;
}
declare module "@salesforce/apex/HomeChildKanbanCls.getPickVals" {
  export default function getPickVals(param: {FldName: any, objName: any}): Promise<any>;
}
declare module "@salesforce/apex/HomeChildKanbanCls.getKanban" {
  export default function getKanban(param: {objName: any, objFields: any, kabnanField: any, ParentRecId: any, relField: any, ExcVal: any, summField: any, KbObjNameField: any}): Promise<any>;
}
declare module "@salesforce/apex/HomeChildKanbanCls.updateRec" {
  export default function updateRec(param: {recId: any, recField: any, recVal: any}): Promise<any>;
}
declare module "@salesforce/apex/HomeChildKanbanCls.deleteRec" {
  export default function deleteRec(param: {obj: any}): Promise<any>;
}
