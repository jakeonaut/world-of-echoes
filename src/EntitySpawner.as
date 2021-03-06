package  
{
	import Entities.Avatar;
	import Entities.Followers.*;
	import Entities.Environment.*;
	import LoaderManagers.EnvironmentManager;
	import Entities.Parents.PlayerFollower;
	import flash.utils.*;
	
	public class EntitySpawner 
	{
		
		public function EntitySpawner() 
		{	
		}
		
		public static function SpawnEntities(baseX:int, baseY:int, entities:Array, map:Dictionary, width:int, height:int, calcX:int, calcY:int, spawnDir:int):void
		{
			for (var i:int = calcX; i < calcX+width; i+=GameWorld.C_WIDTH){
				for (var j:int = calcY+height-GameWorld.C_HEIGHT; j >= calcY; j-=GameWorld.C_HEIGHT){
					var terrain:int = -1;
					/*if (baseX+i >= 1200 && baseX+i < 1680){ 
						if (baseY > -640) terrain = Global.MUSHROOM_FOREST_TERRAIN;
						else terrain = Global.SEA_BREEZE_TERRAIN;
					}
					else */if (baseX+i >= 480 && baseX+i <= 2400) terrain = Global.FOREST_FIELD_TERRAIN;
					else terrain = Global.BEACH_TERRAIN;
					var myGroundLevel:int = baseY-height+j;
					switch(terrain){
						/*case Global.SEA_BREEZE_TERRAIN:
							SpawnEntitiesSeaBreeze(entities, map, width, height, i, j, (myGroundLevel == GameWorld.GROUND_LEVEL));
							break;
						case Global.MUSHROOM_FOREST_TERRAIN:
							SpawnEntitiesMushroomForest(entities, map, width, height, i, j, (myGroundLevel == GameWorld.GROUND_LEVEL), spawnDir);
							break;*/
						case Global.FOREST_FIELD_TERRAIN:
							SpawnEntitiesForest(entities, map, width, height, i, j, (myGroundLevel == GameWorld.GROUND_LEVEL));
							break;
						case Global.BEACH_TERRAIN:
							SpawnEntitiesBeach(entities, map, width, height, i, j, (myGroundLevel == GameWorld.GROUND_LEVEL));
							break;
						default: break;
					}
				}
			}
		}
		
		/*public static function SpawnEntitiesSeaBreeze(entities:Array, map:Dictionary, width:int, height:int, calcX:int, calcY:int, groundLevel:Boolean):void
		{
		}
		
		public static function SpawnEntitiesMushroomForest(entities:Array, map:Dictionary, width:int, height:int, calcX:int, calcY:int, groundLevel:Boolean, spawnDir:int):void
		{
			var rand:int = -1;
			
			var spawnFollower:Boolean = true;
			var followers:Array = [];
			followers.push(new RedMonkey(0, 0));
			followers.push(new HornBird(0, 0));
			
			var i:int;
			var l:int;
			for (i = 0; i < entities.length; i++){
				if (entities[i] is PlayerFollower && !entities[i].followingPlayer) spawnFollower = false;
				else{
					if (entities[i] is RedMonkey){
						for (l = followers.length-1; l >= 0; l--){
							if (followers[l] is RedMonkey){
								followers.splice(l, 1);
								break;
							}
						}
					}else if (entities[i] is HornBird){
						for (l = followers.length-1; l >= 0; l--){
							if (followers[l] is HornBird){
								followers.splice(l, 1);
								break;
							}
						}
					}
				}
			}
			if (groundLevel && spawnDir != Global.DOWN){
				for (var j:int = calcX/16; j < (calcX+width)/16; j++){
					var normString:String = "y"+(i).toString()+"x"+j.toString();					
					if (Math.floor(Math.random()*2) <= 0){
						var height:int = Math.floor(Math.random()*6)+2;
						var swampTree:SwampTreeNode = new SwampTreeNode(j*16-16, calcY+128, height);
						if (Math.floor(Math.random()*4) <= 0){
							if (spawnFollower && followers.length > 0){
								spawnFollower = false;
								rand = Math.floor(Math.random()*followers.length);
								followers[rand].x = swampTree.x+16;
								followers[rand].y = swampTree.y-followers[rand].bb;
								entities.push(followers[rand]);
								followers.splice(rand, 1);
							}
						}
						swampTree.hasShoes = true;
						entities.push(swampTree);
					}	
				}
			}else if (spawnDir != Global.DOWN && spawnDir != Global.UP){
				//TODO:: left/right chunkspawning!!!
			}
			
			for (i = 0; i < entities.length; i++){
				if (entities[i] is SwampTreeNode &&
						((!entities[i].hasAHat && entities[i].y >= 0) || 
						(!entities[i].hasShoes && entities[i].y < 480))){
					
					var height2:int = Math.floor(Math.random()*6)+2;				
					if (!entities[i].hasAHat){
						var swampTree2:SwampTreeNode = new SwampTreeNode(entities[i].x, entities[i].y, height2);
						if (Math.floor(Math.random()*3) <= 0){
							if (spawnFollower && followers.length > 0){
								spawnFollower = false;
								rand = Math.floor(Math.random()*followers.length);
								followers[rand].x = swampTree2.x+16;
								followers[rand].y = swampTree2.y-followers[rand].bb;
								entities.push(followers[rand]);
								followers.splice(rand, 1);
							}
						}
						swampTree2.hasShoes = true;
						entities.push(swampTree2);
					}
					height2 = Math.floor(Math.random()*6)+2;
					if (!entities[i].hasShoes){
						var spawnY:int = entities[i].y+entities[i].bb+(height2*16+32);
						var swampTree3:SwampTreeNode = new SwampTreeNode(entities[i].x, spawnY, height2);
						if (Math.floor(Math.random()*3) <= 0){
							if (spawnFollower && followers.length > 0){
								spawnFollower = false;
								rand = Math.floor(Math.random()*followers.length);
								followers[rand].x = swampTree3.x+16;
								followers[rand].y = swampTree3.y-followers[rand].bb;
								entities.push(followers[rand]);
								followers.splice(rand, 1);
							}
						}
						swampTree3.hasAHat = true;
						entities.push(swampTree3);
					}
				}
			}
		}*/
		
		public static function SpawnEntitiesForest(entities:Array, map:Dictionary, width:int, height:int, calcX:int, calcY:int, groundLevel:Boolean):void
		{
			var rand:int = -1;
			var columns:Array = [];
			
			var spawnFollower:Boolean = true;
			var followers:Array = [];
			if (EnvironmentManager.nightTimer > 0){
				followers.push(new DeerDog(0, 0));
				followers.push(new RedMonkey(0, 0));
				followers.push(new HornBird(0, 0));
			}
			
			var i:int;
			var l:int;
			for (i = 0; i < entities.length; i++){
				if (entities[i] is PlayerFollower && !entities[i].followingPlayer) spawnFollower = false;
				else{
					if (entities[i] is DeerDog){
						for (l = followers.length-1; l >= 0; l--){
							if (followers[l] is DeerDog){
								followers.splice(l, 1);
								break;
							}
						}
					}else if (entities[i] is RedMonkey){
						for (l = followers.length-1; l >= 0; l--){
							if (followers[l] is RedMonkey){
								followers.splice(l, 1);
								break;
							}
						}
					}else if (entities[i] is HornBird){
						for (l = followers.length-1; l >= 0; l--){
							if (followers[l] is HornBird){
								followers.splice(l, 1);
								break;
							}
						}
					}
				}
			}
			for (i = calcY/16; i <= (calcY+height)/16; i++){
				var skipABeat:Boolean;
				for (var j:int = calcX/16; j < (calcX+width)/16; j++){							
					var shouldIContinue:Boolean = false;
					for (var k:int = 0; k < columns.length; k++){
						if (columns[k] == j){
							shouldIContinue = true;
							break;
						}
					}if (shouldIContinue) continue;
					
					var ipu1String:String = "y"+(i).toString()+"x"+j.toString();
					if (map[ipu1String] != null && map[ipu1String].solid){						
						rand = Math.floor(Math.random()*4);
						if (rand <= 0){
							if (spawnFollower && followers.length > 0){
								spawnFollower = false;
								rand = Math.floor(Math.random()*followers.length);
								followers[rand].x = j*16;
								followers[rand].y = i*16-followers[rand].bb;
								entities.push(followers[rand]);
								followers.splice(rand, 1);
							}
						}
						
						if (true){
							columns.push(j);
							columns.push(j+1);
							columns.push(j+2);
							var newTree:Tree = new Tree(j*16-16, i*16-80);
							if (Math.floor(Math.random()*3) <= 0)
								entities.push(new Cicada(newTree.x+Math.floor(Math.random()*8)+18, newTree.y+Math.floor(Math.random()*20)+30, newTree.currAniX));
							if (Math.floor(Math.random()*3) <= 0)
								entities.push(new Cicada(newTree.x+Math.floor(Math.random()*8)+18, newTree.y+Math.floor(Math.random()*10)+50, newTree.currAniX));
							if (EnvironmentManager.nightTimer > 0){
								if (Math.floor(Math.random()*3) <= 0)
									entities.push(new Songbird(newTree.x+8, newTree.y-9, 0));
							}
							entities.push(newTree);
						}
					}
				}
			}
		}
		
		public static function SpawnEntitiesBeach(entities:Array, map:Dictionary, width:int, height:int, calcX:int, calcY:int, groundLevel:Boolean):void
		{
			
			var rand:int = -1;
			var numEntities:int = 0;
			var columns:Array = [];
			var i:int, j:int;
			if (groundLevel){
				for (j = calcX/16; j < (calcX+width)/16; j++){	
					entities.push(new Wave(j*16, (calcY+height)-16, j%6));
				}
			}
			for (i = calcY/16; i <= (calcY+height)/16; i++){
				var skipABeat:Boolean;
				for (j = calcX/16; j < (calcX+width)/16; j++){	
					var shouldIContinue:Boolean = false;
					for (var k:int = 0; k < columns.length; k++){
						if (columns[k] == j){
							shouldIContinue = true;
							break;
						}
					}if (shouldIContinue) continue;
					
					var ipu1String:String = "y"+(i).toString()+"x"+j.toString();
					if (map[ipu1String] != null && map[ipu1String].solid && numEntities < 1){						
						rand = Math.floor(Math.random()*(numEntities*2+8));
						if (rand <= 0 && EnvironmentManager.nightTimer > 0){
							//var randHeight:int = Math.floor(Math.random()*4)+4;
							entities.push(new Seagull((j-1)*16, i*16-9));
							if (Math.floor(Math.random()*2) <= 0)
								entities.push(new Seagull((j-2)*16, i*16-9));
							if (Math.floor(Math.random()*2) <= 0)
								entities.push(new Seagull((j+1)*16, i*16-9));
							if (Math.floor(Math.random()*2) <= 0)
								entities.push(new Seagull(j*16, i*16-9));
							numEntities++;
						}
					}
				}	
			}
		}
		
		public static function Despawn(avatar:Avatar, entities:Array):void
		{
			var i:int;
			var trees:Array = [];
			for (i = entities.length-1; i >= 0; i--){
				if (entities[i] is SwampTreeNode){
					if (entities[i].x+entities[i].rb > 840 ||
						entities[i].x < -60 ||
						entities[i].y+entities[i].bb > 640 ||
						entities[i].y < -140){
							entities.splice(i, 1);
					}else{
						trees.push(entities[i]);
					}
				}else{
					if (entities[i].x+entities[i].rb > 720 ||
						entities[i].x < 0 ||
						entities[i].y+entities[i].bb > 480 ||
						entities[i].y < -80){
							entities.splice(i, 1);
					}
				}
			}for (i = trees.length-1; i >= 0; i--){
				var tree:SwampTreeNode = trees[i];
				if (tree.CheckRectIntersectAbstract(trees, tree.x, tree.y+tree.bb+1, 
						tree.x+tree.rb, tree.y+tree.bb+32, SwampTreeNode, true))
					trees[i].hasShoes = true;
				else trees[i].hasShoes = false;
				if (tree.CheckRectIntersectAbstract(trees, tree.x, tree.y-32, 
						tree.x+tree.rb, tree.y-1, SwampTreeNode, true))
					trees[i].hasAHat = true;
				else trees[i].hasAHat = false;
			}
		}
	}
}