import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import CompleteUI
Item {
    ListModel{
        id:datalist
        ListElement{
            name: "浏阳市"
            ico:"🏙️"
            profile:"浏阳是湖南县级市，花炮之乡，蒸菜发源地"
            address:"浏阳市关口街道办政府前路 1 号"
        }
        ListElement{
            name: "武汉市"
            ico:"🏢"
            profile:"武汉是湖北省省会，九省通衢，长江汉水交汇处"
            address:"武汉市江岸区沿江大道 188 号"
        }
        ListElement{
            name: "昆山市"
            ico:"🏙️"
            profile:"昆山是江苏县级市，全国百强县之首，外资高地"
            address:"昆山市前进中路 108 号"
        }
        ListElement{
            name: "石家庄市"
            ico:"🏢"
            profile:"石家庄是河北省省会，北方重要工业城市"
            address:"石家庄市长安区中山东路 216 号"
        }
        ListElement{
            name: "德阳市"
            ico:"🏦"
            profile:"德阳是四川地级市，重装制造基地，三星堆遗址所在地"
            address:"德阳市旌阳区长江东路 1 号"
        }
        ListElement{
            name: "醴陵市"
            ico:"🏙️"
            profile:"醴陵是湖南县级市，瓷都，中国陶瓷历史文化名城"
            address:"醴陵市左权路 128 号"
        }
        ListElement{
            name: "成都市"
            ico:"🏢"
            profile:"成都是四川省省会，天府之国，大熊猫故乡"
            address:"成都市武侯区蜀锦路 6 号"
        }
        ListElement{
            name: "绍兴市"
            ico:"🏦"
            profile:"绍兴是浙江地级市，鲁迅故里，黄酒之乡，书法圣地"
            address:"绍兴市越城区胜利西路 1 号"
        }
        ListElement{
            name: "常熟市"
            ico:"🏙️"
            profile:"常熟是江苏县级市，服装之城，沙家浜所在地"
            address:"常熟市虞山街道金沙江路 1 号"
        }
        ListElement{
            name: "西安市"
            ico:"🏢"
            profile:"西安是陕西省省会，十三朝古都，丝绸之路起点"
            address:"西安市新城区西华门大街 2 号"
        }
        ListElement{
            name: "义乌市"
            ico:"🏙️"
            profile:"义乌是浙江县级市，小商品之都，世界超市"
            address:"义乌市稠城街道县前街 1 号"
        }
        ListElement{
            name: "温州市"
            ico:"🏦"
            profile:"温州是浙江地级市，民营经济发源地，商人遍天下"
            address:"温州市鹿城区绣山路 1 号"
        }
        ListElement{
            name: "杭州市"
            ico:"🏢"
            profile:"杭州是浙江省省会，电子商务之都，西湖美景甲天下"
            address:"杭州市拱墅区环城北路 318 号"
        }
        ListElement{
            name: "宜都市"
            ico:"🏙️"
            profile:"宜都是湖北县级市，三峡门户，园林城市"
            address:"宜都市陆城街道长江大道 1 号"
        }
        ListElement{
            name: "绵阳市"
            ico:"🏦"
            profile:"绵阳是四川地级市，中国科技城，电子工业基地"
            address:"绵阳市涪城区长虹大道 1 号"
        }
        ListElement{
            name: "南京市"
            ico:"🏢"
            profile:"南京是江苏省省会，六朝古都，教育科研重镇"
            address:"南京市玄武区北京东路 41 号"
        }
        ListElement{
            name: "福清市"
            ico:"🏙️"
            profile:"福清是福建县级市，侨乡，融侨经济技术开发区"
            address:"福清市一拂街 1 号"
        }
        ListElement{
            name: "厦门市"
            ico:"🏦"
            profile:"厦门是福建地级市，海上花园城市，经济特区"
            address:"厦门市思明区湖滨北路 1 号"
        }
        ListElement{
            name: "福州市"
            ico:"🏢"
            profile:"福州是福建省省会，海峡西岸经济区的核心城市"
            address:"福州市鼓楼区乌山路 96 号"
        }
        ListElement{
            name: "江阴市"
            ico:"🏙️"
            profile:"江阴是江苏县级市，中国制造业第一县，乡镇企业发源地"
            address:"江阴市澄江中路 1 号"
        }
        ListElement{
            name: "苏州市"
            ico:"🏦"
            profile:"苏州是江苏地级市，园林城市，GDP超万亿"
            address:"苏州市姑苏区三香路 1 号"
        }
        ListElement{
            name: "济南市"
            ico:"🏢"
            profile:"济南是山东省省会，泉城，大明湖畔趵突泉"
            address:"济南市历下区泺源大街 1 号"
        }
        ListElement{
            name: "太原市"
            ico:"🏢"
            profile:"太原是山西省省会，煤炭能源基地，历史悠久"
            address:"太原市杏花岭区府东街 1 号"
        }
        ListElement{
            name: "郑州市"
            ico:"🏢"
            profile:"郑州是河南省省会，中原腹地，铁路交通枢纽"
            address:"郑州市中原区中原中路 220 号"
        }
        ListElement{
            name: "长沙市"
            ico:"🏢"
            profile:"长沙是湖南省会，人口超千万，靠湘江、在中部挺核心"
            address:"长沙市岳麓区岳麓大道 218 号"
        }
        ListElement{
            name: "株洲市"
            ico:"🏦"
            profile:"株洲是湖南地级市，铁路装备制造基地，动力之都"
            address:"株洲市天元区天台路 58 号"
        }
        ListElement{
            name: "湘潭市"
            ico:"🏦"
            profile:"湘潭是毛泽东故乡，湖南地级市，伟人故里"
            address:"湘潭市雨湖区建设北路 1 号"
        }
        ListElement{
            name: "衡阳市"
            ico:"🏦"
            profile:"衡阳是湖南地级市，湘江之滨，衡山所在地"
            address:"衡阳市石鼓区解放路 1 号"
        }
        ListElement{
            name: "岳阳市"
            ico:"🏦"
            profile:"岳阳是湖南地级市，洞庭湖畔，岳阳楼名闻天下"
            address:"岳阳楼区岳阳大道 28 号"
        }
        ListElement{
            name: "常德市"
            ico:"🏦"
            profile:"常德是湖南地级市，桃花源里的城市，湘西北重镇"
            address:"常德市武陵区朗州路 1 号"
        }
        ListElement{
            name: "郴州市"
            ico:"🏦"
            profile:"郴州是湖南地级市，粤港澳后花园，温泉资源丰富"
            address:"郴州市北湖区鲁塘路 1 号"
        }
        ListElement{
            name: "宁乡市"
            ico:"🏙️"
            profile:"宁乡是湖南县级市，煤炭之乡，宁乡花猪产地"
            address:"宁乡市玉潭街道二环路 1 号"
        }
        ListElement{
            name: "宜宾市"
            ico:"🏦"
            profile:"宜宾是四川地级市，中国酒都，五粮液产地"
            address:"宜宾市翠屏区中山街 1 号"
        }
        ListElement{
            name: "遵义市"
            ico:"🏦"
            profile:"遵义是贵州地级市，革命历史名城，茅台酒产地"
            address:"遵义市汇川区人民路 1 号"
        }
        ListElement{
            name: "安顺市"
            ico:"🏦"
            profile:"安顺是贵州地级市，黄果树瀑布所在地，喀斯特地貌"
            address:"安顺市西秀区中华南路 1 号"
        }
        ListElement{
            name: "珠海市"
            ico:"🏦"
            profile:"珠海是广东地级市，珠江口西岸核心城市，浪漫之城"
            address:"珠海市香洲区人民路 2 号"
        }
        ListElement{
            name: "佛山市"
            ico:"🏦"
            profile:"佛山是广东地级市，岭南文化发源地，武术之乡"
            address:"佛山市禅城区岭南大道 1 号"
        }
        ListElement{
            name: "东莞市"
            ico:"🏦"
            profile:"东莞是广东地级市，世界工厂，制造业名城"
            address:"东莞市南城区鸿福路 1 号"
        }
        ListElement{
            name: "广州市"
            ico:"🏢"
            profile:"广州是广东省省会，千年商都，美食之都，毗邻港澳"
            address:"广州市越秀区府前路 1 号"
        }
        ListElement{
            name: "无锡市"
            ico:"🏦"
            profile:"无锡是江苏地级市，太湖明珠，物联网产业高地"
            address:"无锡市滨湖区太湖大道 1 号"
        }
        ListElement{
            name: "宁波市"
            ico:"🏦"
            profile:"宁波是浙江地级市，港口城市，丝绸之路起点之一"
            address:"宁波市鄞州区宁穿路 1 号"
        }
        ListElement{
            name: "慈溪市"
            ico:"🏙️"
            profile:"慈溪是浙江县级市，家电之都，小家电产业基地"
            address:"慈溪市白沙路街道新城大道 1 号"
        }
        ListElement{
            name: "余姚市"
            ico:"🏙️"
            profile:"余姚是浙江县级市，塑料之乡，模具王国"
            address:"余姚市兰江街道舜水南路 1 号"
        }
        ListElement{
            name: "烟台市"
            ico:"🏦"
            profile:"烟台是山东地级市，沿海开放城市，葡萄酒城"
            address:"烟台市莱山区芙蓉路 1 号"
        }
        ListElement{
            name: "威海市"
            ico:"🏦"
            profile:"威海是山东地级市，海滨花园城市，宜居城市"
            address:"威海市环翠区新威路 1 号"
        }
        ListElement{
            name: "唐山市"
            ico:"🏦"
            profile:"唐山是河北地级市，钢铁工业重镇，河北经济第一"
            address:"唐山市路北区西山道 1 号"
        }
        ListElement{
            name: "洛阳市"
            ico:"🏦"
            profile:"洛阳是河南地级市，十三朝古都，牡丹花城"
            address:"洛阳市洛龙区开元大道 1 号"
        }
        ListElement{
            name: "开封市"
            ico:"🏦"
            profile:"开封是河南地级市，八朝古都，宋都文化"
            address:"开封市龙亭区晋安路 1 号"
        }
        ListElement{
            name: "景德镇市"
            ico:"🏦"
            profile:"景德镇是江西地级市，瓷都，陶瓷艺术之城"
            address:"景德镇市珠山区中华路 1 号"
        }
        ListElement{
            name: "赣州市"
            ico:"🏦"
            profile:"赣州是江西地级市，赣南脐橙之乡，客家文化摇篮"
            address:"赣州市章贡区长征大道 1 号"
        }
        ListElement{
            name: "南昌市"
            ico:"🏢"
            profile:"南昌是江西省省会，革命英雄城，赣江之滨"
            address:"南昌市红谷滩区新府路 118 号"
        }
        ListElement{
            name: "昆明市"
            ico:"🏢"
            profile:"昆明是云南省省会，春城，四季如春气候宜人"
            address:"昆明市呈贡区锦绣大街 1 号"
        }
        ListElement{
            name: "兰州市"
            ico:"🏢"
            profile:"兰州是甘肃省省会，黄河之都，丝绸之路重镇"
            address:"兰州市城关区南滨河路 127 号"
        }
        ListElement{
            name: "南宁市"
            ico:"🏢"
            profile:"南宁是广西壮族自治区首府，绿城中国绿都"
            address:"南宁市青秀区嘉宾路 1 号"
        }
        ListElement{
            name: "贵阳市"
            ico:"🏢"
            profile:"贵阳是贵州省省会，林城，大数据产业基地"
            address:"贵阳市观山湖区林城东路 1 号"
        }
        ListElement{
            name: "海口市"
            ico:"🏢"
            profile:"海口是海南省省会，热带海滨城市，国际旅游岛"
            address:"海口市龙华区玉沙路 28 号"
        }
        ListElement{
            name: "乌鲁木齐市"
            ico:"🏢"
            profile:"乌鲁木齐是新疆维吾尔自治区首府，中亚门户，亚心之都"
            address:"乌鲁木齐市水磨沟区水磨沟路 1 号"
        }
        ListElement{
            name: "银川市"
            ico:"🏢"
            profile:"银川是宁夏回族自治区首府，塞上江南，凤凰城"
            address:"银川市金凤区北京中路 1 号"
        }
        ListElement{
            name: "西宁市"
            ico:"🏢"
            profile:"西宁是青海省省会，夏都，青藏铁路起点"
            address:"西宁市城中区南关街 1 号"
        }
        ListElement{
            name: "拉萨市"
            ico:"🏢"
            profile:"拉萨是西藏自治区首府，雪域高原，日光城，布达拉宫"
            address:"拉萨市城关区江苏路 1 号"
        }
        ListElement{
            name: "呼和浩特市"
            ico:"🏢"
            profile:"呼和浩特是内蒙古自治区首府，塞外青城，草原都市"
            address:"呼和浩特市新城区新华大街 1 号"
        }
        ListElement{
            name: "哈尔滨市"
            ico:"🏢"
            profile:"哈尔滨是黑龙江省省会，东方莫斯科，冰城，夏都"
            address:"哈尔滨市松北区世纪大道 1 号"
        }
        ListElement{
            name: "长春市"
            ico:"🏢"
            profile:"长春是吉林省省会，汽车城，电影节举办地"
            address:"长春市南关区人民大街 1 号"
        }
        ListElement{
            name: "沈阳市"
            ico:"🏢"
            profile:"沈阳是辽宁省省会，工业重镇，历史文化名城"
            address:"沈阳市沈河区市府大路 1 号"
        }
        ListElement{
            name: "大连市"
            ico:"🏦"
            profile:"大连是辽宁地级市，北方明珠，浪漫海滨城市"
            address:"大连市西岗区人民广场 1 号"
        }
        ListElement{
            name: "鞍山市"
            ico:"🏦"
            profile:"鞍山是辽宁地级市，钢铁之都，玉佛苑所在地"
            address:"鞍山市铁东区南胜利路 1 号"
        }
        ListElement{
            name: "吉林市"
            ico:"🏦"
            profile:"吉林是吉林地级市，江城，满族发源地，雾凇奇观"
            address:"吉林市船营区松江路 1 号"
        }
        ListElement{
            name: "大庆市"
            ico:"🏦"
            profile:"大庆是黑龙江地级市，石油之城，工业发达"
            address:"大庆市萨尔图区东风路 1 号"
        }
        ListElement{
            name: "保定市"
            ico:"🏦"
            profile:"保定是河北地级市，首都南大门，历史古城"
            address:"保定市竞秀区东风西路 1 号"
        }
        ListElement{
            name: "沧州市"
            ico:"🏦"
            profile:"沧州是河北地级市，武术之乡，杂技之都"
            address:"沧州市运河区御河路 1 号"
        }
        ListElement{
            name: "廊坊市"
            ico:"🏦"
            profile:"廊坊是河北地级市，京津走廊，地理位置优越"
            address:"廊坊市广阳区金光道 1 号"
        }
        ListElement{
            name: "张家口市"
            ico:"🏦"
            profile:"张家口是河北地级市，草原天路，2022年冬奥会举办地之一"
            address:"张家口市桥西区长青路 1 号"
        }
        ListElement{
            name: "邯郸市"
            ico:"🏦"
            profile:"邯郸是河北地级市，千年古城，赵国都城，钢铁重镇"
            address:"邯郸市丛台区中华大街 1 号"
        }
        ListElement{
            name: "大同市"
            ico:"🏦"
            profile:"大同是山西地级市，煤都，云冈石窟所在地"
            address:"大同市城区迎宾西路 1 号"
        }
        ListElement{
            name: "晋中市"
            ico:"🏦"
            profile:"晋中是山西地级市，晋商故里，平遥古城所在地"
            address:"晋中市榆次区新华街 1 号"
        }
        ListElement{
            name: "临汾市"
            ico:"🏦"
            profile:"临汾是山西地级市，尧都，黄河文明发源地"
            address:"临汾市尧都区府前街 1 号"
        }
        ListElement{
            name: "长治市"
            ico:"🏦"
            profile:"长治是山西地级市，上党盆地，能源之城"
            address:"长治市潞州区英雄路 1 号"
        }
        ListElement{
            name: "许昌市"
            ico:"🏦"
            profile:"许昌是河南地级市，三国文化之乡，曹魏故都"
            address:"许昌市魏都区建安大道 1 号"
        }
        ListElement{
            name: "新乡市"
            ico:"🏦"
            profile:"新乡是河南地级市，豫北重镇，卫河之滨"
            address:"新乡市红旗区人民东路 1 号"
        }
        ListElement{
            name: "焦作市"
            ico:"🏦"
            profile:"焦作是河南地级市，太极拳发源地，云台山所在地"
            address:"焦作市解放区民主路 1 号"
        }
        ListElement{
            name: "南阳市"
            ico:"🏦"
            profile:"南阳是河南地级市，诸葛亮躬耕地，医圣张仲景故乡"
            address:"南阳市卧龙区中州路 1 号"
        }
        ListElement{
            name: "潍坊市"
            ico:"🏦"
            profile:"潍坊是山东地级市，风筝之都，蔬菜之乡"
            address:"潍坊市奎文区胜利街 1 号"
        }
        ListElement{
            name: "淄博市"
            ico:"🏦"
            profile:"淄博是山东地级市，齐国故都，陶瓷琉璃之乡"
            address:"淄博市张店区人民路 1 号"
        }
        ListElement{
            name: "济宁市"
            ico:"🏦"
            profile:"济宁是山东地级市，运河之都，孔孟之乡"
            address:"济宁市任城区红星中路 1 号"
        }
        ListElement{
            name: "泰安市"
            ico:"🏦"
            profile:"泰安是山东地级市，泰山所在地，五岳之首"
            address:"泰安市泰山区岱庙街 1 号"
        }
        ListElement{
            name: "临沂市"
            ico:"🏦"
            profile:"临沂是山东地级市，革命老区，商贸物流中心"
            address:"临沂市兰山区北京路 1 号"
        }
        ListElement{
            name: "扬州市"
            ico:"🏦"
            profile:"扬州是江苏地级市，淮左名都，瘦西湖，烟花三月下扬州"
            address:"扬州市邗江区文昌西路 1 号"
        }
        ListElement{
            name: "镇江市"
            ico:"🏦"
            profile:"镇江是江苏地级市，醋都，焦山金山寺所在地"
            address:"镇江市京口区正东路 1 号"
        }
        ListElement{
            name: "泰州市"
            ico:"🏦"
            profile:"泰州是江苏地级市，凤城，水浒传作者施耐庵故乡"
            address:"泰州市海陵区人民东路 1 号"
        }
        ListElement{
            name: "南通市"
            ico:"🏦"
            profile:"南通是江苏地级市，近代第一城，纺织业发达"
            address:"南通市崇川区世纪大道 1 号"
        }
        ListElement{
            name: "徐州市"
            ico:"🏦"
            profile:"徐州是江苏地级市，五省通衢，淮海战役主战场"
            address:"徐州市云龙区昆仑大道 1 号"
        }
        ListElement{
            name: "连云港市"
            ico:"🏦"
            profile:"连云港是江苏地级市，亚欧大陆桥东桥头堡，海港城市"
            address:"连云港市海州区朝阳东路 1 号"
        }
        ListElement{
            name: "芜湖市"
            ico:"🏦"
            profile:"芜湖是安徽地级市，皖江城市带核心，奇瑞汽车所在地"
            address:"芜湖市镜湖区文化路 1 号"
        }
        ListElement{
            name: "蚌埠市"
            ico:"🏦"
            profile:"蚌埠是安徽地级市，皖北中心城市，铁路枢纽"
            address:"蚌埠市蚌山区东海大道 1 号"
        }
        ListElement{
            name: "马鞍山市"
            ico:"🏦"
            profile:"马鞍山是安徽地级市，钢城，南京都市圈成员"
            address:"马鞍山市雨山区太白大道 1 号"
        }
        ListElement{
            name: "安庆市"
            ico:"🏦"
            profile:"安庆是安徽地级市，皖江城市带，黄梅戏故乡"
            address:"安庆市迎江区皖江大道 1 号"
        }
        ListElement{
            name: "阜阳市"
            ico:"🏦"
            profile:"阜阳是安徽地级市，皖北重镇，人口超千万"
            address:"阜阳市颍州区清河路 1 号"
        }
        ListElement{
            name: "湖州市"
            ico:"🏦"
            profile:"湖州是浙江地级市，太湖南岸，丝绸之府，鱼米之乡"
            address:"湖州市吴兴区仁皇山路 1 号"
        }
        ListElement{
            name: "嘉兴市"
            ico:"🏦"
            profile:"嘉兴是浙江地级市，党的诞生地，江南水乡"
            address:"嘉兴市南湖区广场路 1 号"
        }
        ListElement{
            name: "金华市"
            ico:"🏦"
            profile:"金华是浙江地级市，火腿之乡，义乌小商品市场所在地"
            address:"金华市婺城区双龙南街 1 号"
        }
        ListElement{
            name: "泉州市"
            ico:"🏦"
            profile:"泉州是福建地级市，海上丝绸之路起点，民营经济强"
            address:"泉州市丰泽区府东路 1 号"
        }
        ListElement{
            name: "枣阳市"
            ico:"🏙️"
            profile:"枣阳是湖北县级市，帝乡，刘秀故乡"
            address:"枣阳市人民路 1 号"
        }
        ListElement{
            name: "大冶市"
            ico:"🏙️"
            profile:"大冶是湖北县级市，青铜之都，劲牌酒产地"
            address:"大冶市湛月路 1 号"
        }
        ListElement{
            name: "当阳市"
            ico:"🏙️"
            profile:"当阳是湖北县级市，三国古城，赵子龙大战长坂坡之地"
            address:"当阳市玉阳街道子龙路 1 号"
        }
        ListElement{
            name: "枝江市"
            ico:"🏙️"
            profile:"枝江是湖北县级市，三峡之尾，化工产业基地"
            address:"枝江市马家店街道江汉大道 1 号"
        }
        ListElement{
            name: "钟祥市"
            ico:"🏙️"
            profile:"钟祥是湖北县级市，世界文化遗产明显陵所在地"
            address:"钟祥市郢中街道石城大道 1 号"
        }
        ListElement{
            name: "天门市"
            ico:"🏙️"
            profile:"天门是湖北县级市，茶圣陆羽故乡，中国蒸菜之乡"
            address:"天门市竟陵街道陆羽大道 1 号"
        }
        ListElement{
            name: "潜江市"
            ico:"🏙️"
            profile:"潜江是湖北县级市，油田城市，小龙虾之乡"
            address:"潜江市园林街道江汉路 1 号"
        }
        ListElement{
            name: "仙桃市"
            ico:"🏙️"
            profile:"仙桃是湖北县级市，体操之乡，亚洲体操比赛金牌产地"
            address:"仙桃市沔阳大道 1 号"
        }
        ListElement{
            name: "冷水江市"
            ico:"🏙️"
            profile:"冷水江是湖南县级市，世界锑都，锡矿山所在地"
            address:"冷水江市冷水江街道锑都路 1 号"
        }
        ListElement{
            name: "耒阳市"
            ico:"🏙️"
            profile:"耒阳是湖南县级市，造纸术发明家蔡伦故乡"
            address:"耒阳市蔡伦路 1 号"
        }
        ListElement{
            name: "常宁市"
            ico:"🏙️"
            profile:"常宁是湖南县级市，油茶之乡，有色金属之乡"
            address:"常宁市宜阳镇青阳路 1 号"
        }
        ListElement{
            name: "汨罗市"
            ico:"🏙️"
            profile:"汨罗是湖南县级市，端午龙舟节发源地，屈原投江处"
            address:"汨罗市归义镇建设路 1 号"
        }
        ListElement{
            name: "临湘市"
            ico:"🏙️"
            profile:"临湘是湖南县级市，围棋之乡，湖南北大门"
            address:"临湘市长安路 1 号"
        }
        ListElement{
            name: "资兴市"
            ico:"🏙️"
            profile:"资兴是湖南县级市，东江湖畔，煤炭工业基地"
            address:"资兴市唐洞街道晋宁路 1 号"
        }
        ListElement{
            name: "武冈市"
            ico:"🏙️"
            profile:"武冈是湖南县级市，武冈卤菜发源地，铜鹅之乡"
            address:"武冈市迎春亭街道都梁路 1 号"
        }
        ListElement{
            name: "邵东市"
            ico:"🏙️"
            profile:"邵东是湖南县级市，商贸之城，打火机之乡"
            address:"邵东市大禾塘街道办政府路 1 号"
        }
        ListElement{
            name: "张家港市"
            ico:"🏙️"
            profile:"张家港是江苏县级市，港口城市，全国文明城市"
            address:"张家港市杨舍镇人民中路 1 号"
        }
        ListElement{
            name: "太仓市"
            ico:"🏙️"
            profile:"太仓是江苏县级市，江南鱼米之乡，港口城市"
            address:"太仓市城厢镇县府街 1 号"
        }
        ListElement{
            name: "东阳市"
            ico:"🏙️"
            profile:"东阳是浙江县级市，木雕之乡，建筑之乡，横店影视城"
            address:"东阳市吴宁街道江滨北路 1 号"
        }
        ListElement{
            name: "永康市"
            ico:"🏙️"
            profile:"永康是浙江县级市，五金之都，门业产业基地"
            address:"永康市东城街道金城路 1 号"
        }
        ListElement{
            name: "温岭市"
            ico:"🏙️"
            profile:"温岭是浙江县级市，鞋业之都，曙光新城"
            address:"温岭市太平街道人民东路 1 号"
        }
        ListElement{
            name: "瑞安市"
            ico:"🏙️"
            profile:"瑞安是浙江县级市，汽摩配之都，中国包装机械城"
            address:"瑞安市安阳街道万松东路 1 号"
        }
        ListElement{
            name: "乐清市"
            ico:"🏙️"
            profile:"乐清是浙江县级市，低压电器之都，雁荡山所在地"
            address:"乐清市城东街道伯乐路 1 号"
        }
        ListElement{
            name: "诸暨市"
            ico:"🏙️"
            profile:"诸暨是浙江县级市，珍珠之乡，袜业之都，西施故里"
            address:"诸暨市暨阳街道东一路 1 号"
        }
        ListElement{
            name: "海宁市"
            ico:"🏙️"
            profile:"海宁是浙江县级市，皮都，潮乡，中国皮革城"
            address:"海宁市硖石街道海州西路 1 号"
        }
        ListElement{
            name: "桐乡市"
            ico:"🏙️"
            profile:"桐乡是浙江县级市，羊毛衫之乡，乌镇所在地"
            address:"桐乡市梧桐街道振兴路 1 号"
        }
        ListElement{
            name: "灵宝市"
            ico:"🏙️"
            profile:"灵宝是河南县级市，黄金之城，苹果之乡"
            address:"灵宝市金城大道 1 号"
        }
        ListElement{
            name: "永城市"
            ico:"🏙️"
            profile:"永城是河南县级市，煤化工基地，汉兴之地"
            address:"永城市东方大道 1 号"
        }
        ListElement{
            name: "项城市"
            ico:"🏙️"
            profile:"项城是河南县级市，味精之都，防水产业基地"
            address:"项城市人民路 1 号"
        }
        ListElement{
            name: "新郑市"
            ico:"🏙️"
            profile:"新郑是河南县级市，轩辕故里，红枣之乡"
            address:"新郑市中华路 1 号"
        }
        ListElement{
            name: "登封市"
            ico:"🏙️"
            profile:"登封是河南县级市，嵩山少林寺所在地，功夫之乡"
            address:"登封市少林大道 1 号"
        }
        ListElement{
            name: "林州市"
            ico:"🏙️"
            profile:"林州是河南县级市，红旗渠精神发源地，建筑之都"
            address:"林州市红旗渠大道 1 号"
        }
        ListElement{
            name: "禹州市"
            ico:"🏙️"
            profile:"禹州是河南县级市，钧瓷之都，中药材集散地"
            address:"禹州市禹王大道 1 号"
        }
        ListElement{
            name: "长葛市"
            ico:"🏙️"
            profile:"长葛是河南县级市，金刚石之都，再生铝产业基地"
            address:"长葛市葛天大道 1 号"
        }
        ListElement{
            name: "汝州市"
            ico:"🏙️"
            profile:"汝州是河南县级市，汝瓷之都，曲剧发源地"
            address:"汝州市丹阳路 1 号"
        }
        ListElement{
            name: "邓州市"
            ico:"🏙️"
            profile:"邓州是河南县级市，医圣张仲景故里，南水北调中线渠首"
            address:"邓州市三贤路 1 号"
        }
        ListElement{
            name: "巩义市"
            ico:"🏙️"
            profile:"巩义是河南县级市，工业强市，竹林镇所在地"
            address:"巩义市行政路 1 号"
        }
        ListElement{
            name: "石狮市"
            ico:"🏙️"
            profile:"石狮是福建县级市，服装名城，闽南商阜"
            address:"石狮市八七路 1 号"
        }
        ListElement{
            name: "晋江市"
            ico:"🏙️"
            profile:"晋江是福建县级市，品牌之都，安踏七匹狼所在地"
            address:"晋江市世纪大道 1 号"
        }
        ListElement{
            name: "南安市"
            ico:"🏙️"
            profile:"南安是福建县级市，建材之乡，石材之都"
            address:"南安市溪美街 1 号"
        }
        ListElement{
            name: "龙海市"
            ico:"🏙️"
            profile:"龙海是福建县级市，食品之城，闽南金三角"
            address:"龙海市石码镇人民路 1 号"
        }
        ListElement{
            name: "长乐市"
            ico:"🏙️"
            profile:"长乐是福建县级市，纺织产业基地，滨海新城"
            address:"长乐市吴航街道会堂路 1 号"
        }
        ListElement{
            name: "平度市"
            ico:"🏙️"
            profile:"平度是山东县级市，青岛后厨，家电配套产业基地"
            address:"平度市凤台街道人民路 1 号"
        }
        ListElement{
            name: "胶州市"
            ico:"🏙️"
            profile:"胶州是山东县级市，胶州大白菜产地，机械装备制造基地"
            address:"胶州市北京路 1 号"
        }
        ListElement{
            name: "即墨市"
            ico:"🏙️"
            profile:"即墨是山东县级市，纺织服装名城，商贸市场发达"
            address:"即墨市振华街 1 号"
        }
        ListElement{
            name: "蓬莱市"
            ico:"🏙️"
            profile:"蓬莱是山东县级市，人间仙境，葡萄酒产区"
            address:"蓬莱市登州路 1 号"
        }
        ListElement{
            name: "招远市"
            ico:"🏙️"
            profile:"招远是山东县级市，中国金都，黄金储量丰富"
            address:"招远市温泉路 1 号"
        }
        ListElement{
            name: "栖霞市"
            ico:"🏙️"
            profile:"栖霞是山东县级市，苹果之都，果业产业基地"
            address:"栖霞市腾飞路 1 号"
        }
        ListElement{
            name: "龙口市"
            ico:"🏙️"
            profile:"龙口是山东县级市，港口城市，南山集团所在地"
            address:"龙口市港城大道 1 号"
        }
        ListElement{
            name: "莱州市"
            ico:"🏙️"
            profile:"莱州是山东县级市，石材之都，月季之乡"
            address:"莱州市府前街 1 号"
        }
        ListElement{
            name: "昌邑市"
            ico:"🏙️"
            profile:"昌邑是山东县级市，丝绸之乡，绿化苗木基地"
            address:"昌邑市平安街 1 号"
        }
        ListElement{
            name: "高密市"
            ico:"🏙️"
            profile:"高密是山东县级市，扑灰年画产地，纺织产业基地"
            address:"高密市人民大街 1 号"
        }
        ListElement{
            name: "寿光市"
            ico:"🏙️"
            profile:"寿光是山东县级市，中国菜都，蔬菜之乡"
            address:"寿光市圣城街 1 号"
        }
        ListElement{
            name: "安丘市"
            ico:"🏙️"
            profile:"安丘是山东县级市，食品加工基地，葱姜之乡"
            address:"安丘市青云大街 1 号"
        }
        ListElement{
            name: "诸城市"
            ico:"🏙️"
            profile:"诸城是山东县级市，密州烤鸡产地，汽车产业基地"
            address:"诸城市繁荣路 1 号"
        }
        ListElement{
            name: "青州市"
            ico:"🏙️"
            profile:"青州是山东县级市，古九州之一，花卉之乡"
            address:"青州市范公亭路 1 号"
        }
        ListElement{
            name: "曲阜市"
            ico:"🏙️"
            profile:"曲阜是山东县级市，孔子故里，东方圣城"
            address:"曲阜市半壁街 1 号"
        }
        ListElement{
            name: "邹城市"
            ico:"🏙️"
            profile:"邹城是山东县级市，孟子故里，煤电产业基地"
            address:"邹城市平阳路 1 号"
        }
        ListElement{
            name: "新泰市"
            ico:"🏙️"
            profile:"新泰是山东县级市，煤电之城，输变电产业基地"
            address:"新泰市府前大街 1 号"
        }
        ListElement{
            name: "肥城市"
            ico:"🏙️"
            profile:"肥城是山东县级市，桃都，中国佛桃之乡"
            address:"肥城市龙山路 1 号"
        }
        ListElement{
            name: "石家庄市"
            ico:"🏢"
            profile:"石家庄是河北省省会，北方重要工业城市"
            address:"石家庄市长安区中山东路 216 号"
        }
        ListElement{
            name: "藁城市"
            ico:"🏙️"
            profile:"藁城是河北县级市，藁城宫灯产地，历史上薄氏封地"
            address:"藁城区廉州西路 1 号"
        }
        ListElement{
            name: "新乐市"
            ico:"🏙️"
            profile:"新乐是河北县级市，古中山国所在地，伏羲台遗址"
            address:"新乐市长寿路 1 号"
        }
        ListElement{
            name: "辛集市"
            ico:"🏙️"
            profile:"辛集是河北县级市，中国皮革之都，皮衣之乡"
            address:"辛集市市府街 1 号"
        }
        ListElement{
            name: "晋州市"
            ico:"🏙️"
            profile:"晋州是河北县级市，魏征故里，晋州鸭梨产地"
            address:"晋州市向阳街 1 号"
        }
        ListElement{
            name: "赵县"
            ico:"🏙️"
            profile:"赵县是河北县级市，赵州桥所在地，河北梨果之乡"
            address:"赵县府前街 1 号"
        }
        ListElement{
            name: "廊坊市"
            ico:"🏦"
            profile:"廊坊是河北地级市，京津走廊，地理位置优越"
            address:"廊坊市广阳区金光道 1 号"
        }
        ListElement{
            name: "三河市"
            ico:"🏙️"
            profile:"三河是河北县级市，燕郊镇所在地，京东明珠"
            address:"三河市鼎盛大街 1 号"
        }
        ListElement{
            name: "霸州市"
            ico:"🏙️"
            profile:"霸州是河北县级市，冀中明珠，胜芳古镇所在地"
            address:"霸州市迎宾道 1 号"
        }
        ListElement{
            name: "固安县"
            ico:"🏙️"
            profile:"固安是河北县级市，首都南大门，大兴国际机场所在地"
            address:"固安县新中街 1 号"
        }
        ListElement{
            name: "保定市"
            ico:"🏦"
            profile:"保定是河北地级市，首都南大门，历史古城"
            address:"保定市竞秀区东风西路 1 号"
        }
        ListElement{
            name: "涿州市"
            ico:"🏙️"
            profile:"涿州是河北县级市，桃园三结义发生地，历史文化名城"
            address:"涿州市范阳路 1 号"
        }
        ListElement{
            name: "定州市"
            ico:"🏙️"
            profile:"定州是河北县级市，中山古都，河北省历史文化名城"
            address:"定州市中山路 1 号"
        }
        ListElement{
            name: "安国市"
            ico:"🏙️"
            profile:"安国是河北县级市，药都，北方最大的中药材集散地"
            address:"安国市祁州药城路 1 号"
        }
        ListElement{
            name: "高碑店市"
            ico:"🏙️"
            profile:"高碑店是河北县级市，白沟镇所在地箱包产业基地"
            address:"高碑店市迎宾路 1 号"
        }
        ListElement{
            name: "沧州市"
            ico:"🏦"
            profile:"沧州是河北地级市，武术之乡，杂技之都"
            address:"沧州市运河区御河路 1 号"
        }
        ListElement{
            name: "任丘市"
            ico:"🏙️"
            profile:"任丘是河北县级市，华北油田所在地，白洋淀畔"
            address:"任丘市会战道 1 号"
        }
        ListElement{
            name: "黄骅市"
            ico:"🏙️"
            profile:"黄骅是河北县级市，港口城市，渤海新区核心"
            address:"黄骅市渤海路 1 号"
        }
        ListElement{
            name: "河间市"
            ico:"🏙️"
            profile:"河间是河北县级市，工艺玻璃之乡，驴肉火烧发源地"
            address:"河间市曙光路 1 号"
        }
        ListElement{
            name: "衡水市"
            ico:"🏦"
            profile:"衡水是河北地级市，教育强市，衡水中学闻名全国"
            address:"衡水市桃城区育才街 1 号"
        }
        ListElement{
            name: "冀州市"
            ico:"🏙️"
            profile:"冀州是河北县级市，衡水市辖区，历史文化古城"
            address:"冀州区冀新路 1 号"
        }
        ListElement{
            name: "深州市"
            ico:"🏙️"
            profile:"深州是河北县级市，蜜桃之乡，河北鸭梨主产区"
            address:"深州市长江路 1 号"
        }
        ListElement{
            name: "邢台市"
            ico:"🏦"
            profile:"邢台是河北地级市，卧牛城，百泉之城"
            address:"邢台市襄都区中华大街 1 号"
        }
        ListElement{
            name: "南宫市"
            ico:"🏙️"
            profile:"南宫是河北县级市，冀南红色教育基地，棉花之乡"
            address:"南宫市东进街 1 号"
        }
        ListElement{
            name: "沙河市"
            ico:"🏙️"
            profile:"沙河是河北县级市，玻璃产业基地，冀南工业重镇"
            address:"沙河市太行街 1 号"
        }
        ListElement{
            name: "武安市"
            ico:"🏙️"
            profile:"武安是河北县级市，煤铁之乡，太极拳发源地之一"
            address:"武安市塔西路 1 号"
        }
        ListElement{
            name: "邯郸市"
            ico:"🏦"
            profile:"邯郸是河北地级市，千年古城，赵国都城，钢铁重镇"
            address:"邯郸市丛台区中华大街 1 号"
        }
        ListElement{
            name: "武安市"
            ico:"🏙️"
            profile:"武安是河北县级市，煤铁之乡，旅游业发达"
            address:"武安市中兴路 1 号"
        }
        ListElement{
            name: "大同市"
            ico:"🏦"
            profile:"大同是山西地级市，煤都，云冈石窟所在地"
            address:"大同市城区迎宾西路 1 号"
        }
        ListElement{
            name: "阳泉市"
            ico:"🏦"
            profile:"阳泉是山西地级市，煤铁之乡，娘子关所在地"
            address:"阳泉市城区北大街 1 号"
        }
        ListElement{
            name: "长治市"
            ico:"🏦"
            profile:"长治是山西地级市，上党盆地，能源之城"
            address:"长治市潞州区英雄路 1 号"
        }
        ListElement{
            name: "潞城市"
            ico:"🏙️"
            profile:"潞城是山西县级市，煤焦产业基地，上党古城"
            address:"潞城市中华大街 1 号"
        }
        ListElement{
            name: "晋城市"
            ico:"🏦"
            profile:"晋城是山西地级市，煤炭资源丰富，太行山南麓"
            address:"晋城市城区凤台街 1 号"
        }
        ListElement{
            name: "高平市"
            ico:"🏙️"
            profile:"高平是山西县级市，炎帝故里，长平之战发生地"
            address:"高平市长平街 1 号"
        }
        ListElement{
            name: "朔州市"
            ico:"🏦"
            profile:"朔州是山西地级市，电力能源基地，陶瓷之乡"
            address:"朔州市朔城区鄯阳街 1 号"
        }
        ListElement{
            name: "怀仁市"
            ico:"🏙️"
            profile:"怀仁是山西县级市，陶瓷产业基地羔羊肉产地"
            address:"怀仁市怀玉街 1 号"
        }
        ListElement{
            name: "晋中市"
            ico:"🏦"
            profile:"晋中是山西地级市，晋商故里，平遥古城所在地"
            address:"晋中市榆次区新华街 1 号"
        }
        ListElement{
            name: "介休市"
            ico:"🏙️"
            profile:"介休是山西县级市，绵山所在地，晋商文化发源地"
            address:"介休市北大街 1 号"
        }
        ListElement{
            name: "运城市"
            ico:"🏦"
            profile:"运城是山西地级市，关公故里，山西南部重镇"
            address:"运城市盐湖区河东街 1 号"
        }
        ListElement{
            name: "永济市"
            ico:"🏙️"
            profile:"永济是山西县级市，鹳雀楼所在地，黄河岸边"
            address:"永济市舜都大道 1 号"
        }
        ListElement{
            name: "河津市"
            ico:"🏙️"
            profile:"河津是山西县级市，煤炭和铝工业基地，大禹治水之地"
            address:"河津市新耿街 1 号"
        }
        ListElement{
            name: "临汾市"
            ico:"🏦"
            profile:"临汾是山西地级市，尧都，黄河文明发源地"
            address:"临汾市尧都区府前街 1 号"
        }
        ListElement{
            name: "侯马市"
            ico:"🏙️"
            profile:"侯马是山西县级市，晋国都城遗址，晋商博物院"
            address:"侯马市市府路 1 号"
        }
        ListElement{
            name: "霍州市"
            ico:"🏙️"
            profile:"霍州是山西县级市，霍州署所在地，佛教禅宗古刹"
            address:"霍州市东大街 1 号"
        }
        ListElement{
            name: "吕梁市"
            ico:"🏦"
            profile:"吕梁是山西地级市，煤炭资源丰富，革命老区"
            address:"吕梁市离石区永宁中路 1 号"
        }
        ListElement{
            name: "孝义市"
            ico:"🏙️"
            profile:"孝义是山西县级市，山西首富县市，铝工业基地"
            address:"孝义市府前街 1 号"
        }
        ListElement{
            name: "汾阳市"
            ico:"🏙️"
            profile:"汾阳是山西县级市，汾酒故乡，核桃产业基地"
            address:"汾阳市胜利街 1 号"
        }
        ListElement{
            name: "忻州市"
            ico:"🏦"
            profile:"忻州是山西地级市，五台山所在地，佛教圣地"
            address:"忻州市忻府区长征街 1 号"
        }
        ListElement{
            name: "原平市"
            ico:"🏙️"
            profile:"原平是山西县级市，酥梨之乡，山西北部重要城市"
            address:"原平市京原街 1 号"
        }
        ListElement{
            name: "临汾市"
            ico:"🏦"
            profile:"临汾是山西地级市，尧都，黄河文明发源地"
            address:"临汾市尧都区府前街 1 号"
        }
        ListElement{
            name: "古交市"
            ico:"🏙️"
            profile:"古交是山西县级市，煤炭资源型城市，太原卫星城"
            address:"古交市金牛街 1 号"
        }
        ListElement{
            name: "清徐县"
            ico:"🏙️"
            profile:"清徐是山西县级市，醋都，葡萄之乡，山西老陈醋主产地"
            address:"清徐县紫林路 1 号"
        }
        ListElement{
            name: "呼和浩特市"
            ico:"🏢"
            profile:"呼和浩特是内蒙古自治区首府，塞外青城，草原都市"
            address:"呼和浩特市新城区新华大街 1 号"
        }
        ListElement{
            name: "包头市"
            ico:"🏦"
            profile:"包头是内蒙古地级市，草原钢城，稀土之都"
            address:"包头市昆都仑区钢铁大街 1 号"
        }
        ListElement{
            name: "鄂尔多斯市"
            ico:"🏦"
            profile:"鄂尔多斯是内蒙古地级市，煤炭资源丰富，绒纺产业基地"
            address:"鄂尔多斯市康巴什区鄂尔多斯大街 1 号"
        }
        ListElement{
            name: "乌海市"
            ico:"🏦"
            profile:"乌海是内蒙古地级市，沙漠绿洲，焦化产业基地"
            address:"乌海市海勃湾区新华街 1 号"
        }
        ListElement{
            name: "赤峰市"
            ico:"🏦"
            profile:"赤峰是内蒙古地级市，红山文化发源地，草原都市"
            address:"赤峰市松山区玉龙街 1 号"
        }
        ListElement{
            name: "通辽市"
            ico:"🏦"
            profile:"通辽是内蒙古地级市，蒙古族文化中心，科尔沁草原"
            address:"通辽市科尔沁区霍林郭勒路 1 号"
        }
        ListElement{
            name: "呼伦贝尔市"
            ico:"🏦"
            profile:"呼伦贝尔是内蒙古地级市，世界四大草原之一，牧业发达"
            address:"呼伦贝尔市海拉尔区阿里河路 1 号"
        }
        ListElement{
            name: "巴彦淖尔市"
            ico:"🏦"
            profile:"巴彦淖尔是内蒙古地级市，河套平原，葵花之乡"
            address:"巴彦淖尔市临河区新华街 1 号"
        }
        ListElement{
            name: "乌兰察布市"
            ico:"🏦"
            profile:"乌兰察布是内蒙古地级市，草原避暑之都，马铃薯之乡"
            address:"乌兰察布市集宁区察哈尔街 1 号"
        }
        ListElement{
            name: "满洲里市"
            ico:"🏙️"
            profile:"满洲里是内蒙古县级市，中国最大陆路口岸，俄式风情"
            address:"满洲里市华埠街 1 号"
        }
        ListElement{
            name: "二连浩特市"
            ico:"🏙️"
            profile:"二连浩特是内蒙古县级市，恐龙之乡，北方重要口岸"
            address:"二连浩特市新华大街 1 号"
        }
        ListElement{
            name: "根河市"
            ico:"🏙️"
            profile:"根河是内蒙古县级市，中国冷极，驯鹿之乡"
            address:"根河市中央街 1 号"
        }
        ListElement{
            name: "阿尔山市"
            ico:"🏙️"
            profile:"阿尔山是内蒙古县级市，温泉之城，森林矿泉资源"
            address:"阿尔山市温泉街 1 号"
        }
        ListElement{
            name: "霍林郭勒市"
            ico:"🏙️"
            profile:"霍林郭勒是内蒙古县级市，草原煤城，露天煤矿基地"
            address:"霍林郭勒市珠斯花大街 1 号"
        }
        ListElement{
            name: "沈阳市"
            ico:"🏢"
            profile:"沈阳是辽宁省省会，工业重镇，历史文化名城"
            address:"沈阳市沈河区市府大路 1 号"
        }
        ListElement{
            name: "鞍山市"
            ico:"🏦"
            profile:"鞍山是辽宁地级市，钢铁之都，玉佛苑所在地"
            address:"鞍山市铁东区南胜利路 1 号"
        }
        ListElement{
            name: "抚顺市"
            ico:"🏦"
            profile:"抚顺是辽宁地级市，煤都，皇家极地海洋世界"
            address:"抚顺市顺城区临江路 1 号"
        }
        ListElement{
            name: "本溪市"
            ico:"🏦"
            profile:"本溪是辽宁地级市，本溪水洞，五女山世界文化遗产"
            address:"本溪市明山区人民路 1 号"
        }
        ListElement{
            name: "丹东市"
            ico:"🏦"
            profile:"丹东是辽宁地级市，边境城市，鸭绿江畔"
            address:"丹东市振兴区锦山大街 1 号"
        }
        ListElement{
            name: "锦州市"
            ico:"🏦"
            profile:"锦州是辽宁地级市，辽西走廊，锦州烧烤名吃"
            address:"锦州市太和区市府路 1 号"
        }
        ListElement{
            name: "营口市"
            ico:"🏦"
            profile:"营口是辽宁地级市，渤海入海口，港口城市"
            address:"营口市站前区辽河大街 1 号"
        }
        ListElement{
            name: "阜新市"
            ico:"🏦"
            profile:"阜新是辽宁地级市，煤电之城，篮球之乡"
            address:"阜新市海州区中华路 1 号"
        }
        ListElement{
            name: "辽阳市"
            ico:"🏦"
            profile:"辽阳是辽宁地级市，石化产业基地，历史文化古城"
            address:"辽阳市白塔区中华大街 1 号"
        }
        ListElement{
            name: "盘锦市"
            ico:"🏦"
            profile:"盘锦是辽宁地级市，湿地之都，红海滩奇观"
            address:"盘锦市兴隆台区石油大街 1 号"
        }
        ListElement{
            name: "铁岭市"
            ico:"🏦"
            profile:"铁岭是辽宁地级市，小品之乡，煤炭资源型城市"
            address:"铁岭市银州区工人街 1 号"
        }
        ListElement{
            name: "朝阳市"
            ico:"🏦"
            profile:"朝阳是辽宁地级市，三燕古都，化石产地"
            address:"朝阳市双塔区朝阳大街 1 号"
        }
        ListElement{
            name: "葫芦岛市"
            ico:"🏦"
            profile:"葫芦岛是辽宁地级市，渤海湾畔，泳装产业基地"
            address:"葫芦岛市龙港区龙湾大街 1 号"
        }
        ListElement{
            name: "新民市"
            ico:"🏙️"
            profile:"新民是辽宁县级市，公主屯镇所在地，辽河油田"
            address:"新民市府前街 1 号"
        }
        ListElement{
            name: "瓦房店市"
            ico:"🏙️"
            profile:"瓦房店是辽宁县级市，轴承之都，桃李之乡"
            address:"瓦房店市世纪广场 1 号"
        }
        ListElement{
            name: "庄河市"
            ico:"🏙️"
            profile:"庄河是辽宁县级市，海鲜之都，冰峪沟旅游胜地"
            address:"庄河市红岩路 1 号"
        }
        ListElement{
            name: "海城市"
            ico:"🏙️"
            profile:"海城是辽宁县级市，纺织产业基地，商贸活跃"
            address:"海城市黄河路 1 号"
        }
        ListElement{
            name: "东港市"
            ico:"🏙️"
            profile:"东港是辽宁县级市，沿海城市，草莓之乡"
            address:"东港市东港路 1 号"
        }
        ListElement{
            name: "凤城市"
            ico:"🏙️"
            profile:"凤城是辽宁县级市，凤凰山所在地，边境城市"
            address:"凤城市邓铁梅路 1 号"
        }
        ListElement{
            name: "凌源市"
            ico:"🏙️"
            profile:"凌源是辽宁县级市，化石产地，北方重要蔬菜集散地"
            address:"凌源市东盛街 1 号"
        }
        ListElement{
            name: "北镇市"
            ico:"🏙️"
            profile:"北镇是辽宁县级市，医巫闾山所在地，葡萄之乡"
            address:"北镇市广宁街 1 号"
        }
        ListElement{
            name: "盖州市"
            ico:"🏙️"
            profile:"盖州是辽宁县级市，渤海沿岸，绒山羊之乡"
            address:"盖州市红旗大街 1 号"
        }
        ListElement{
            name: "大石桥市"
            ico:"🏙️"
            profile:"大石桥是辽宁县级市，镁都，中国镁都之一"
            address:"大石桥市人民大街 1 号"
        }
        ListElement{
            name: "开原市的"
            ico:"🏙️"
            profile:"开原是辽宁县级市，清河水库所在地，粮食之乡"
            address:"开原市新华路 1 号"
        }
        ListElement{
            name: "调兵山市"
            ico:"🏙️"
            profile:"调兵山是辽宁县级市，煤炭资源型城市，蒸汽机车博物馆"
            address:"调兵山市振兴路 1 号"
        }
        ListElement{
            name: "灯塔市"
            ico:"🏙️"
            profile:"灯塔是辽宁县级市，服装产业基地，辽阳下辖"
            address:"灯塔市建设街 1 号"
        }
        ListElement{
            name: "长春市"
            ico:"🏢"
            profile:"长春是吉林省省会，汽车城，电影节举办地"
            address:"长春市南关区人民大街 1 号"
        }
        ListElement{
            name: "吉林市"
            ico:"🏦"
            profile:"吉林是吉林地级市，江城，满族发源地，雾凇奇观"
            address:"吉林市船营区松江路 1 号"
        }
        ListElement{
            name: "四平市"
            ico:"🏦"
            profile:"四平是吉林地级市，英雄城，玉米之乡"
            address:"四平市铁西区英雄大街 1 号"
        }
        ListElement{
            name: "辽源市"
            ico:"🏦"
            profile:"辽源是吉林地级市，煤炭资源枯竭转型城市，袜业基地"
            address:"辽源市龙山区辽河大路 1 号"
        }
        ListElement{
            name: "通化市"
            ico:"🏦"
            profile:"通化是吉林地级市，医药之城，葡萄酒产地"
            address:"通化市东昌区新华大街 1 号"
        }
        ListElement{
            name: "白山市"
            ico:"🏦"
            profile:"白山是吉林地级市，长白山脚下，矿泉城"
            address:"白山市浑江区长庆街 1 号"
        }
        ListElement{
            name: "松原市"
            ico:"🏦"
            profile:"松原是吉林地级市，石油资源丰富，查干湖冬捕"
            address:"松原市宁江区沿江街 1 号"
        }
        ListElement{
            name: "白城市"
            ico:"🏦"
            profile:"白城是吉林地级市，草原城市，向海自然保护区"
            address:"白城市洮北区新华街 1 号"
        }
        ListElement{
            name: "延吉市"
            ico:"🏙️"
            profile:"延吉是吉林县级市，延边朝鲜族自治州首府，朝鲜族文化"
            address:"延吉市解放路 1 号"
        }
        ListElement{
            name: "图们市"
            ico:"🏙️"
            profile:"图们是吉林县级市，边境城市，朝鲜族聚居地"
            address:"图们市口岸街 1 号"
        }
        ListElement{
            name: "敦化市"
            ico:"🏙️"
            profile:"敦化是吉林县级市，六鼎山佛像，敖东古城"
            address:"敦化市新华路 1 号"
        }
        ListElement{
            name: "珲春市"
            ico:"🏙️"
            profile:"珲春是吉林县级市，防川风景区，东北亚重要口岸"
            address:"珲春市河南街 1 号"
        }
        ListElement{
            name: "龙井市"
            ico:"🏙️"
            profile:"龙井是吉林县级市，朝鲜族茶文化，苹果梨之乡"
            address:"龙井市安民街 1 号"
        }
        ListElement{
            name: "公主岭市"
            ico:"🏙️"
            profile:"公主岭是吉林县级市，玉米之乡，汽车零部件基地"
            address:"公主岭市河南街 1 号"
        }
        ListElement{
            name: "梅河口市"
            ico:"🏙️"
            profile:"梅河口是吉林县级市，医药产业基地，松下电器生产基地"
            address:"梅河口市人民大街 1 号"
        }
        ListElement{
            name: "集安市"
            ico:"🏙️"
            profile:"集安是吉林县级市，高句丽遗址，世界文化遗产"
            address:"集安市鸭江路 1 号"
        }
        ListElement{
            name: "桦甸市"
            ico:"🏙️"
            profile:"桦甸是吉林县级市，森林资源丰富，红石森林公园"
            address:"桦甸市莲花路 1 号"
        }
        ListElement{
            name: "舒兰市"
            ico:"🏙️"
            profile:"舒兰是吉林县级市，粮食主产区，舒兰大米产地"
            address:"舒兰市人民大路 1 号"
        }
        ListElement{
            name: "磐石市"
            ico:"🏙️"
            profile:"磐石是吉林县级市，金属冶炼基地，农业发达"
            address:"磐石市人民路 1 号"
        }
        ListElement{
            name: "双辽市"
            ico:"🏙️"
            profile:"双辽是吉林县级市，草原城市，能源转型城市"
            address:"双辽市辽河路 1 号"
        }
        ListElement{
            name: "东辽县"
            ico:"🏙️"
            profile:"东辽是吉林县级市，禽蛋之乡，辽源市下辖"
            address:"东辽县白泉镇正街 1 号"
        }
        ListElement{
            name: "东丰县"
            ico:"🏙️"
            profile:"东丰是吉林县级市，梅花鹿之乡，中国梅花鹿地理标志"
            address:"东丰县东丰镇建设路 1 号"
        }
        ListElement{
            name: "哈尔滨"
            ico:"🏢"
            profile:"哈尔滨是黑龙江省省会，东方莫斯科，冰城，夏都"
            address:"哈尔滨市松北区世纪大道 1 号"
        }
        ListElement{
            name: "齐齐哈尔市"
            ico:"🏦"
            profile:"齐齐哈尔是黑龙江地级市，鹤城，丹顶鹤故乡"
            address:"齐齐哈尔市建华区中华路 1 号"
        }
        ListElement{
            name: "鸡西市"
            ico:"🏦"
            profile:"鸡西是黑龙江地级市，煤炭资源型城市，版画之乡"
            address:"鸡西市鸡冠区红旗路 1 号"
        }
        ListElement{
            name: "鹤岗市"
            ico:"🏦"
            profile:"鹤岗是黑龙江地级市，煤炭资源枯竭型城市，龙江三峡"
            address:"鹤岗市向阳区红军路 1 号"
        }
        ListElement{
            name: "双鸭山市"
            ico:"🏦"
            profile:"双鸭山是黑龙江地级市，煤炭基地，安邦河湿地"
            address:"双鸭山市尖山区友谊路 1 号"
        }
        ListElement{
            name: "大庆市"
            ico:"🏦"
            profile:"大庆是黑龙江地级市，石油之城，工业发达"
            address:"大庆市萨尔图区东风路 1 号"
        }
        ListElement{
            name: "伊春市"
            ico:"🏦"
            profile:"伊春是黑龙江地级市，林都，红松故乡"
            address:"伊春市伊春区新兴大街 1 号"
        }
        ListElement{
            name: "佳木斯市"
            ico:"🏦"
            profile:"佳木斯是黑龙江地级市，三江平原，农机产业基地"
            address:"佳木斯市向阳区长安路 1 号"
        }
        ListElement{
            name: "七台河市"
            ico:"🏦"
            profile:"七台河是黑龙江地级市，煤炭资源型城市，家具产业"
            address:"七台河市桃山区山湖路 1 号"
        }
        ListElement{
            name: "牡丹江市"
            ico:"🏦"
            profile:"牡丹江是黑龙江地级市，冰雪旅游名城，镜泊湖"
            address:"牡丹江市东安区新安街 1 号"
        }
        ListElement{
            name: "黑河市"
            ico:"🏦"
            profile:"黑河是黑龙江地级市，中俄边境，黑龙江大桥"
            address:"黑河市爱辉区通江路 1 号"
        }
        ListElement{
            name: "绥化市"
            ico:"🏦"
            profile:"绥化是黑龙江地级市，农业大市，绿色食品基地"
            address:"绥化市北林区人和街 1 号"
        }
        ListElement{
            name: "尚志市"
            ico:"🏙️"
            profile:"尚志是黑龙江县级市，革命老区，苇沙河漂流"
            address:"尚志市中央大街 1 号"
        }
        ListElement{
            name: "五常市"
            ico:"🏙️"
            profile:"五常是黑龙江县级市，五常大米产地，拉林古城"
            address:"五常市建设大街 1 号"
        }
        ListElement{
            name: "海林市"
            ico:"🏙️"
            profile:"海林是黑龙江县级市，林海雪原，威虎山故里"
            address:"海林市英雄街 1 号"
        }
        ListElement{
            name: "宁安市"
            ico:"🏙️"
            profile:"宁安是黑龙江县级市，渤海国遗址，镜泊湖景区"
            address:"宁安市中心街 1 号"
        }
        ListElement{
            name: "穆棱市"
            ico:"🏙️"
            profile:"穆棱是黑龙江县级市，大豆之乡，边境城市"
            address:"穆棱市工农街 1 号"
        }
        ListElement{
            name: "绥芬河市"
            ico:"🏙️"
            profile:"绥芬河是黑龙江县级市，中俄重要口岸，玉石之乡"
            address:"绥芬河市黄河路 1 号"
        }
        ListElement{
            name: "东宁市"
            ico:"🏙️"
            profile:"东宁是黑龙江县级市，祖母绿产地，口岸城市"
            address:"东宁市中华路 1 号"
        }
        ListElement{
            name: "铁力市"
            ico:"🏙️"
            profile:"铁力是黑龙江县级市，林业资源，伊春下辖"
            address:"铁力市建设大街 1 号"
        }
        ListElement{
            name: "同江市"
            ico:"🏙️"
            profile:"同江是黑龙江县级市，黑龙江畔，赫哲族聚居地"
            address:"同江市通江街 1 号"
        }
        ListElement{
            name: "富锦市"
            ico:"🏙️"
            profile:"富锦是黑龙江县级市，三江平原，粮食产量大县"
            address:"富锦市中央大街 1 号"
        }
        ListElement{
            name: "抚远市"
            ico:"🏙️"
            profile:"抚远是黑龙江县级市，中国最东端，黑瞎子岛"
            address:"抚远市正阳路 1 号"
        }
        ListElement{
            name: "北安市"
            ico:"🏙️"
            profile:"北安是黑龙江县级市，红色城市，黑龙江省北部重要城市"
            address:"北安市交通街 1 号"
        }
        ListElement{
            name: "五大连池市"
            ico:"🏙️"
            profile:"五大连池是黑龙江县级市，火山地质公园，矿泉城"
            address:"五大连池市青山路 1 号"
        }
        ListElement{
            name: "安达市"
            ico:"🏙️"
            profile:"安达是黑龙江县级市，乳业之城，黑龙江西部重要城市"
            address:"安达市正阳街 1 号"
        }
        ListElement{
            name: "肇东市"
            ico:"🏙️"
            profile:"肇东是黑龙江县级市，哈尔滨卫星城，绿色产业基地"
            address:"肇东市正阳街 1 号"
        }
    }

    Component {
        id: defaultdata
        Item {
            anchors.fill: parent
            anchors.margins: 4
            ComImage{
                anchors.left: parent.left
                anchors.top: parent.top
                id:_ico
                iconsource: modeldata.ico

            }
            Text {
                anchors.left: _ico.right
                anchors.right: parent.right
                anchors.verticalCenter: _ico.verticalCenter
                anchors.leftMargin: 10
                id: _name
                text:modeldata.name
                font.bold: true
                font.pixelSize: 16
            }

            ComCheckBox{
                anchors.top: parent.top
                anchors.right:parent.right
                anchors.topMargin: 5
                anchors.rightMargin: 5
                checked:comListView.currentIndex==indexId? true:false

            }
            Text {
                anchors.topMargin: 4
                anchors.top: _name.bottom
                anchors.left:parent.left
                anchors.right: parent.right
                anchors.leftMargin: 3
                id: address
                text:modeldata.address
                font.pixelSize: 12
                color: "#005BAB"
            }
            Text {
                anchors.topMargin: 1
                anchors.left:parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: 3
                id: profile
                text:modeldata.profile
                font.pixelSize: 13
                 elide: Text.ElideRight
                 color: "#322965"
            }
        }


    }

    ComListView{
        id:comListView
        itemHeight:68
        model: datalist
        delegate:defaultdata

    }
}