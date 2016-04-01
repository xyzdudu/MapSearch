package
{
	public class MapSearch
	{
		private static var _results:Array;
		private static var _startScene:Number = 0;
		private static var _endScene:Number = 0;
		private static var _teleportModel:TeleportGraphModel;
		private static var _dijkstra:Dijkstra;
		
		public static function find(startScene:Number,endScene:Number):Array
		{
			_teleportModel = new TeleportGraphModel();
			_dijkstra = new Dijkstra(_teleportModel.graph,DoorTemplateList.mapDoorIndex[startScene],_teleportModel.distance,_teleportModel.path);
			var iTargetMapIdIndex:int = DoorTemplateList.mapDoorIndex[endScene];
			var arrPath:Array = [];
			arrPath.push(endScene);
			var dic:Dictionary = DoorTemplateList.mapDoorIndex;
			for(var i:int = 0; i < _teleportModel.distance[DoorTemplateList.mapDoorIndex[endScene]]; i ++)
			{
				iTargetMapIdIndex = _teleportModel.graph.getPoint(_teleportModel.path[iTargetMapIdIndex]);
				for(var teleport:Object in DoorTemplateList.mapDoorIndex)
				{
					if(DoorTemplateList.mapDoorIndex[teleport] == iTargetMapIdIndex)
					{
						arrPath.push(teleport);
						break;
					}
				}
			}
			_results = [];
			for(var j:int = arrPath.length - 1; j >= 0; j --)
			{
				for each(var door:DoorTemplateInfo in DoorTemplateList.sceneDoorList[arrPath[j]])
				{
					if(j == 0)
						continue;
					if(door.mapId == arrPath[j] && door.nextMapId == arrPath[j - 1])
						_results.push(door);
				}
			}
			
			//原本是把所有地图做成一个图，但由于配置问题，会被划分了多个图，这些划分出来的图是主场景、副本，
			//判断最后一个场景是不是目标场景就可以防止跨图寻路
			var lastDoor:DoorTemplateInfo = _results[_results.length - 1];
			if(lastDoor.nextMapId != endScene)
				return [];
			return _results;
		}
	}
}