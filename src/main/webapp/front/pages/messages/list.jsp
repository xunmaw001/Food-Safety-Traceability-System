<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<!-- 在线留言 -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<title>留言板</title>
		<link rel="stylesheet" href="../../layui/css/layui.css">
		<!-- 样式 -->
		<link rel="stylesheet" href="../../css/style.css" />
		<!-- 主题（主要颜色设置） -->
		<link rel="stylesheet" href="../../css/theme.css" />
		<!-- 通用的css -->
		<link rel="stylesheet" href="../../css/common.css" />
	</head>
	<style>
		#swiper {
			overflow: hidden;
		}
		#swiper .layui-carousel-ind li {
			width: 16px;
			height: 10px;
			border-width: 0;
			border-style: solid;
			border-color: rgba(0,0,0,.3);
			border-radius: 3px;
			background-color: #f7f7f7;
			box-shadow: 0 0 6px rgba(110,22,64,.8);
		}
		#swiper .layui-carousel-ind li.layui-this {
			width: 24px;
			height: 10px;
			border-width: 0;
			border-style: solid;
			border-color: rgba(0,0,0,.3);
			border-radius: 10px;
			background-color: rgba(51, 126, 106, 1);
			box-shadow: 0 0 6px rgba(110,22,64,.8);
		}
		
		.index-title {
		    text-align: center;
		    box-sizing: border-box;
		    width: 980px;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    flex-direction: column;
		}
		
		.layui-laypage .layui-laypage-count {
		  padding: 0 10px;
		}
		.layui-laypage .layui-laypage-skip {
		  padding-left: 10px;
		}
	</style>
	<body>

		<div id="app">
			<!-- 轮播图 -->
			<div class="layui-carousel" id="swiper" :style='{"boxShadow":"0 0 0px rgba(110,22,64,.8)","margin":"0 auto","borderColor":"rgba(0,0,0,.3)","borderRadius":"5px","borderWidth":"0","width":"100%","borderStyle":"solid"}'>
			  <div carousel-item id="swiper-item">
				<div v-for="(item,index) in swiperList" :key="index">
					<img style="width: 100%;height: 100%;object-fit:cover;" :src="item.img" />
				</div>
			  </div>
			</div>
			<!-- 轮播图 -->

			<!-- 标题 -->
			<div class="index-title" :style='{"padding":"10px","boxShadow":"1px -30px 0px 0px #337e6a","margin":"50px auto 20px","borderColor":"rgba(0,0,0,.3)","backgroundColor":"rgba(241, 241, 241, 1)","color":"rgba(51, 126, 106, 1)","borderRadius":"40px","borderWidth":"1px","fontSize":"20px","borderStyle":"solid","height":"auto"}'>
			  <span>MESSAGES / ADVICE</span><span>留言板</span>
			</div>
			<!-- 标题 -->

			<div class="message-container" style="padding: 20px 0;">
				<form class="layui-form message-form" :style='{"padding":"20px","boxShadow":"0 0 6px #337e6a","margin":"0 0 20px 0","borderColor":"rgba(110,22,64,.3)","backgroundColor":"#fff","borderRadius":"4px","borderWidth":"0","borderStyle":"solid"}'>
					<div class="layui-form-item layui-form-text" style="display: flex;align-items: center;margin:0">
						<label class="layui-form-label" style="width: auto;" :style='{"padding":"0","minWidth":"54px","fontSize":"14px","color":"#333","textAlign":"center"}'>留言</label>
						<div class="layui-input-block" style="margin:0;flex:1;">
							<textarea :style='{"padding":"10px","boxShadow":"0 0 6px #da9939","borderColor":"rgba(0,0,0,.3)","backgroundColor":"#fff","color":"#333","borderRadius":"4px","borderWidth":"0","fontSize":"14px","borderStyle":"solid","height":"120px"}' name="content" required lay-verify="required" placeholder="请输入内容" class="layui-textarea"></textarea>
						</div>
					</div>
                                        <div class="layui-form-item layui-form-text" style="display: flex;align-items: center;margin-top:10px">
                                            <div class="layui-form-item" pane>
                                                <label class="layui-form-label" style="width: auto;" :style='{"padding":"0","minWidth":"54px","fontSize":"14px","color":"#333","textAlign":"center"}'>图片</label>
                                                <div v-if="cpicture" class="layui-input-block">
                                                        <img id="cpictureImg" style="width: 100px;height: 100px;border-radius: 50%;border: 2px solid #EEEEEE;" :src="baseurl+cpicture">
                                                        <input type="hidden" :value="cpicture" id="cpicture" name="cpicture" />
                                                </div>
                                                <div class="layui-input-block">
                                                        <button type="button" class="layui-btn btn-theme" id="cpictureUpload">
                                                                <i class="layui-icon">&#xe67c;</i>上传图片
                                                        </button>
                                                </div>
                                           </div>
                                        </div>
					<div class="layui-form-item">
						<div class="layui-input-block">
							<button :style='{"padding":"0 10px","boxShadow":"0 0 6px #337e6a","margin":"10px 5px 0","borderColor":"rgba(0,0,0,.3)","backgroundColor":"rgba(51, 126, 106, 1)","color":"#fff","borderRadius":"4px","borderWidth":"0","width":"auto","lineHeight":"34px","fontSize":"14px","borderStyle":"solid"}' class="layui-btn btn-submit" lay-submit lay-filter="*">立即提交</button>
							<button :style='{"padding":"0 10px","boxShadow":"0 0 6px #337e6a","margin":"10px 5px 0","borderColor":"rgba(0,0,0,.3)","backgroundColor":"#fff","color":"rgba(51, 126, 106, 1)","borderRadius":"4px","borderWidth":"0","width":"auto","lineHeight":"34px","fontSize":"14px","borderStyle":"solid"}' type="reset" class="layui-btn layui-btn-primary">重置</button>
						</div>
					</div>
				</form>
				<div class="message-list" v-if="dataList.length" :style='{"padding":"0 20px 20px","boxShadow":"0 0 6px #337e6a","margin":"0","borderColor":"rgba(110,22,64,.3)","backgroundColor":"#fff","borderRadius":"4px","borderWidth":"0","borderStyle":"solid"}'>
					<div :style='{"padding":"20px 0","boxShadow":"0 0 6px rgba(255,0,0,0)","margin":"0","borderColor":"rgba(0,0,0,.3)","backgroundColor":"#fff","borderRadius":"0","borderWidth":"0 0 1px 0","borderStyle":"solid"}'  class="message-item" v-for="(item,index) in dataList" v-bind:key="index" >
						<div class="username-container" style="display: flex;align-items: center;">
							<img :style='{"boxShadow":"0 0 6px rgba(110,22,64,.3)","margin":"0 10px 0 0","borderColor":"rgba(0,0,0,.3)","borderRadius":"100%","borderWidth":"0","width":"40px","borderStyle":"solid","height":"40px"}' class="avator" src="../../img/avator.png">
							<span style="display: inline-block;" :style='{"padding":"0 10px","boxShadow":"0 0 6px #337e6a","margin":"0","borderColor":"rgba(0,0,0,.3)","backgroundColor":"#fff","color":"#333","borderRadius":"4px","borderWidth":"0","width":"auto","lineHeight":"28px","fontSize":"14px","borderStyle":"solid"}' class="username">用户：{{item.username}}</span>
						</div>
						<div class="content" class="content" style="margin: 0;flex: 1;">
							<span style="display: inline-block;" :style='{"padding":"8px","boxShadow":"0 0 6px #337e6a","margin":"8px 0 0 50px","borderColor":"rgba(0,0,0,.3)","backgroundColor":"rgba(51, 126, 106, 0.54)","color":"#fff","borderRadius":"4px","borderWidth":"0","fontSize":"14px","borderStyle":"solid"}' class="message">
								{{item.content}}
							</span>
						</div>
						<div v-if="item.cpicture" class="content" style="margin: 0;flex: 1;">
                                                        <img style="max-width: 600px;max-height: 600px;border: 2px solid #EEEEEE;margin:8px 0 0 50px;" :src="baseurl+item.cpicture">
                                                </div>
						<div v-if="item.reply" class="replay" style="margin: 0;flex: 1;background: transparent;padding: 0;">
							<span style="display: inline-block;" :style='{"padding":"8px","boxShadow":"0 0 6px #337e6a","margin":"8px 0 0 50px","borderColor":"rgba(0,0,0,.3)","backgroundColor":"rgba(51, 126, 106, 0.54)","color":"#fff","borderRadius":"4px","borderWidth":"0","fontSize":"14px","borderStyle":"solid"}' class="label">回复：{{item.reply}}</span>
							<!-- <span class="message">
								{{item.reply}}
							</span> -->
						</div>
                                                <div v-if="item.rpicture" class="content" style="margin: 0;flex: 1;">
                                                        <img style="max-width: 600px;max-height: 600px;border: 2px solid #EEEEEE;margin:8px 0 0 50px;" :src="baseurl+item.rpicture">
                                                </div>
					</div>
				</div>
				<div class="pager" id="pager" :style="{textAlign:2==1?'left':2==2?'center':'right'}"></div>
			</div>
		</div>

		<!-- layui -->
		<script src="../../layui/layui.js"></script>
		<!-- vue -->
		<script src="../../js/vue.js"></script>
		<!-- 组件配置信息 -->
		<script src="../../js/config.js"></script>
		<!-- 扩展插件配置信息 -->
		<script src="../../modules/config.js"></script>
		<!-- 工具方法 -->
		<script src="../../js/utils.js"></script>

		<script>
			var vue = new Vue({
				el: '#app',
				data: {
					// 轮播图
					swiperList: [{
						img: '../../img/banner.jpg'
					}],
					cpicture: '',
					baseurl:'',
					dataList: []
				},
				filters: {
					newsDesc: function(val) {
						if (val) {
							if (val.length > 200) {
								return val.substring(0, 200).replace(/<[^>]*>/g).replace(/undefined/g, '');
							} else {
								return val.replace(/<[^>]*>/g).replace(/undefined/g, '');
							}
						}
						return '';
					}
				},
				methods: {
					jump(url) {
						jump(url)
					}
				}
			})

			layui.use(['layer','upload', 'element', 'carousel', 'laypage', 'http', 'jquery', 'form'], function() {
				var layer = layui.layer;
				var upload = layui.upload;
				var element = layui.element;
				var carousel = layui.carousel;
				var laypage = layui.laypage;
				var http = layui.http;
				var form = layui.form;
				var jquery = layui.jquery;

				var limit = 5;
				vue.baseurl = http.baseurl;

				// 获取轮播图 数据
				http.request('config/list', 'get', {
					page: 1,
					limit: 5
				}, function(res) {
					if (res.data.list.length > 0) {
						var swiperItemHtml = '';
						for (let item of res.data.list) {
							if (item.name.indexOf('picture') >= 0 && item.value && item.value != "" && item.value != null) {
								swiperItemHtml +=
									'<div>' +
									'<img class="swiper-item" style="width: 100%;height: 100%;object-fit:cover;" src="' + http.baseurl+item.value + '">' +
									'</div>';
							}
						}
						jquery('#swiper-item').html(swiperItemHtml);
						
						vue.$nextTick(() => {
						  carousel.render({
						  	elem: '#swiper',
							width: '100%',
						  	height: '350px',
						  	arrow: 'hover',
						  	anim: 'default',
						  	autoplay: 'true',
						  	interval: '3000',
						  	indicator: 'inside'
						  });
						
						})
					}
				});

				// 获取列表数据
				init();

				function init() {
					// 获取列表数据
					http.request('messages/list', 'get', {
						page: 1,
						limit: limit
					}, function(res) {
						vue.dataList = res.data.list
						// 分页
						laypage.render({
							elem: 'pager',
							count: res.data.total,
							limit: limit,
							groups: 5,
							layout: ["prev","page","next"],
							theme: '#337E6A',
							jump: function(obj, first) {
								//首次不执行
								if (!first) {
									http.request('messages/list', 'get', {
										page: obj.curr,
										limit: obj.limit
									}, function(res) {
										vue.dataList = res.data.list
									})
								}
							}
						});
					})
				}
				//上传图片
                                var cpictureUpload = upload.render({
                                        //绑定元素
                                        elem: '#cpictureUpload',
                                        //上传接口
                                        url: http.baseurl + 'file/upload',
                                         //请求头
                                        headers: {
                                                Token: localStorage.getItem('Token')
                                        },
                                         //允许上传时校验的文件类型
                                        accept: 'images',
                                        before: function() {
                                                //loading层
                                                var index = layer.load(1, {
                                                        shade: [0.1, '#fff'] //0.1透明度的白色背景
                                                });
                                        },
                                         //上传成功
                                        done: function(res) {
                                                console.log(res);
                                                layer.closeAll();
                                                if (res.code == 0) {
                                                        layer.msg("上传成功", {
                                                                time: 2000,
                                                                icon: 6
                                                        })
                                                        var url = 'upload/' + res.file;
                                                        jquery('#cpicture').val(url);
                                                        vue.cpicture = url;
                                                } else {
                                                        layer.msg(res.msg, {
                                                                time: 2000,
                                                                icon: 5
                                                        })
                                                }
                                        },
                                        //请求异常回调
                                        error: function() {
                                                layer.closeAll();
                                                layer.msg("请求接口异常", {
                                                        time: 2000,
                                                        icon: 5
                                                })
                                        }
                                });
				// 提交数据
				form.on('submit(*)', function(data) {
					data = data.field;
					data.userid = localStorage.getItem('userid')
					data.username = localStorage.getItem('adminName')
					http.requestJson('messages/add', 'post', data, function(res) {
						layer.msg('留言成功', {
							time: 2000,
							icon: 6
						}, function() {
							window.location.reload();
						});
						return false
					});
					return false
				});

			});
		</script>
	</body>
</html>
