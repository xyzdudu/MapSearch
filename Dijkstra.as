package
{
	/**
	 * 狄克斯特拉算法 
	 * 
	 */	
	public class Dijkstra
	{
		private static const MAXWEIGHT : int = 1000;   //最大权值
		
		//图从下标point结点到其他结点的最短距离distance和最短路径下标path
		public function Dijkstra(graph : GraphModel, point : int, distance : Array, path : Array)
		{
			var kipointnum : int = graph.getTotalPoint();
			
			var karrayS : Array = [];
			var kiminDis : int = 0;  //最短距离
			var i : int = 0;
			var j : int = 0;
			var u : int = 0;
			
			//初始化
			for(i = 0; i < kipointnum; i ++)
			{
				distance[i] = graph.getWeight(point, i);
				karrayS.push( 0 );
				if(i != point && distance[i] < MAXWEIGHT)
				{
					path[i] = point;
				}
				else
				{
					path[i] = -1;
				}
			}
			
			karrayS[point] = 1;   //标记结点point已从集合T加入到集合S中
			
			//在当前还未找到最短路径的结点集中选取具有最短距离的结点u
			for(i = 0; i < kipointnum; i ++)
			{
				kiminDis = MAXWEIGHT;
				for(j = 0; j < kipointnum; j ++)
				{
					if(karrayS[j] == 0 && distance[j] < kiminDis)
					{
						u = j;
						kiminDis = distance[j];
					}
				}
				
				//当已不再存在路径时算法结束
				if(kiminDis == MAXWEIGHT)
				{
					return;
				}
				
				karrayS[u] = 1;   //标记结点u已从集合T加入到集合S中
				
				//修改从point到其他结点的最短距离和最短路径
				for(j = 0; j < kipointnum; j ++)
				{
					if(karrayS[j] == 0 && graph.getWeight(u, j) < MAXWEIGHT && (distance[u] + graph.getWeight(u, j)) < distance[j])
					{
						//结点point经结点u到其他结点的最短距离和最短路径
						distance[j] = distance[u] + graph.getWeight(u, j);
						path[j] = u;
					}
				}
			}
		}
	}
}