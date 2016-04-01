package
{
	public class TeleportGraphModel
	{
		protected var m_Teleporter:Object;   //传送点XML
		
		private var m_arrTeleport : Array = [];  //传送点
		private var m_arrWeight : Array = [];  //权值	
		
		public var m_mapScene2Teleteporter:Object; //传送点信息
		public var m_Graph : GraphModel;
		public var m_mapTeleport : Object;
		public var m_distance : Array;
		public var m_path : Array;
		
		public function TeleportGraphModel()
		{
			this.m_mapTeleport = new Object();
			this.m_mapScene2Teleteporter = {};
			
			m_Teleporter = ConfigManager.instance.getConfigObjByName( "alltrans" );
			var kiindex : int = 0;
			if ( m_Teleporter != null )
			{
				for each ( var itemXML:Object in m_Teleporter )
				{
					if ( itemXML is String )
					{
						continue;
					}
					if ( itemXML is Array )
					{
						continue;
					}
					var strSceneID:String = itemXML.sceneId;
					var vctSceneTransferes:Vector.<Object>;
					if ( m_mapScene2Teleteporter.hasOwnProperty( strSceneID ))
					{
						vctSceneTransferes = m_mapScene2Teleteporter[ strSceneID ];
					}
					else
					{
						vctSceneTransferes = new Vector.<Object>();
						m_mapScene2Teleteporter[ strSceneID ] = vctSceneTransferes;
						this.m_mapTeleport[ strSceneID ] = kiindex;
						this.m_arrTeleport.push( kiindex );
						kiindex ++;
					}
					vctSceneTransferes.push( itemXML );
				}
			}
			
			for each(var kvctscene : Vector.<Object> in m_mapScene2Teleteporter )
			{
				for(var i : int = 0; i < kvctscene.length; i ++)
				{
					this.m_arrWeight.push( {"row":this.m_mapTeleport[kvctscene[i].sceneId], "col":this.m_mapTeleport[kvctscene[i].gotoScene], "weight":1} );
				}
			}
			
			var kiTeleportLength : int = this.m_arrTeleport.length;
			var kiWeightLength : int = this.m_arrWeight.length;
			this.m_Graph = new GraphModel(kiTeleportLength);
			this.CreatGraph(this.m_Graph, this.m_arrTeleport, kiTeleportLength, this.m_arrWeight, kiWeightLength);
			
			var kiTotalTeleport : int = this.m_Graph.getTotalPoint();
			this.m_distance = new Array( kiTotalTeleport );
			this.m_path = new Array( kiTotalTeleport );
		}	
		
		/**
		 * 建立图，所建立的图有pointnum个结点arrpoint[0]...arrpoint[pointnum - 1]，有edgenum条边arrweight[0]...arrweight[edgenum - 1] 
		 * @param graph
		 * @param arrpoint
		 * @param arrweight
		 * @param edge
		 * 
		 */		
		private function CreatGraph(graph : GraphModel, arrpoint : Array, pointnum : int, arrweight : Array, edgenum : int):void
		{
			//向图中插入pointnum个结点arrpoint[0]...arrpoint[pointnum - 1]
			for(var i : int = 0; i < pointnum; i ++)
			{
				graph.InsertPoint(arrpoint[i]);
			}
			for(var j : int = 0; j < edgenum; j ++)
			{
				graph.InsertEdge(arrweight[j].row, arrweight[j].col, arrweight[j].weight);	
			}
		}
	}
}