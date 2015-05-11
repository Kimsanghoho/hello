package com.example.FoodFinder;

import java.util.ArrayList;

import android.app.TabActivity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.ContextMenu;
import android.view.ContextMenu.ContextMenuInfo;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TabHost;
import android.widget.Toast;
import android.widget.TabHost.TabSpec;

public class ffmain extends TabActivity {
	ArrayList<String> data = new ArrayList<String>();
	ArrayList<String> savedata = new ArrayList<String>();
	String id = null;
	String foodname = null;
	String restaurantname = null;
	String addr = null;
	String search_1 = null;
	String search1 = null;
	String serviceUrl = null;
	String search_2 = null;

	int i;
	int j=0;
	private TabHost m_tabHost = null;

	ImageView img;

	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.ffmain);
		

		Intent now_it = getIntent();
		id = now_it.getStringExtra("login_id");
		search_1 = now_it.getStringExtra("search_1");

		img = (ImageView) findViewById(R.id.btn_click);
		registerForContextMenu(img);
		

		/** TabHost ID */
		m_tabHost = (TabHost) findViewById(android.R.id.tabhost);
		TabSpec aaa_TabSpec = m_tabHost.newTabSpec("aaa");
		TabSpec bbb_TabSpec = m_tabHost.newTabSpec("bbb");
		TabSpec ccc_TabSpec = m_tabHost.newTabSpec("ccc");

		/**
		 * Resources res = getResources(); // 리소스 객체 생성 TabHost tabHost =
		 * getTabHost(); // 탭메뉴 액티비티 생성 TabHost.TabSpec spec; // 각 탭의 메뉴와 컨텐츠를
		 * 위한 객체 선언 Intent intent; // 각 탭에서 사용할 인텐트 선언 // 탭에 그려질 아이콘을 저장할 객체
		 */

		LayoutInflater vi1 = (LayoutInflater) getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		LayoutInflater vi2 = (LayoutInflater) getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		View View_1 = (View) vi1.inflate(R.layout.tab_row_item, null);
		View View_2 = (View) vi2.inflate(R.layout.tab_row_item, null);
		LinearLayout Layout_1 = (LinearLayout) View_1
				.findViewById(R.id.LinearLayout01);
		LinearLayout Layout_2 = (LinearLayout) View_2
				.findViewById(R.id.LinearLayout01);

		Layout_1.setBackgroundResource(R.drawable.tab_1_bg);
		Layout_2.setBackgroundResource(R.drawable.tab_2_bg);

		Intent aaa_it = new Intent(this, recommend.class);
		aaa_it.putExtra("login_id", id);

		aaa_TabSpec.setIndicator(View_1);
		aaa_TabSpec.setContent(aaa_it);

		Intent bbb_it = new Intent(this, tema.class);
		bbb_it.putExtra("login_id", id);

		bbb_TabSpec.setIndicator(View_2);
		bbb_TabSpec.setContent(bbb_it);


		/** 탭을 TabHost 에 추가한다 */
		m_tabHost.addTab(aaa_TabSpec);
		m_tabHost.addTab(bbb_TabSpec);

		m_tabHost.getTabWidget().setCurrentTab(0);
	}

	
	
	
	public void onCreateContextMenu(ContextMenu menu, View v,
			ContextMenuInfo menuInfo) {
	
		
			
		
	
		super.onCreateContextMenu(menu, v, menuInfo);

		menu.setHeaderIcon(android.R.drawable.btn_star);

		menu.setHeaderTitle("설정");
		menu.add(0, 1, 0, "취향 재설정");
		menu.add(0, 2, 0, "검색");
		menu.add(0, 3, 0, "재추천");
		menu.add(0, 4, 0, "로그아웃");
	}

	@Override
	public boolean onContextItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case 1:
			Intent it = new Intent(ffmain.this, select.class);
			it.putExtra("id", id);
			startActivity(it);
			finish();
			return true;
		case 2:
			
			Intent it1 = new Intent(ffmain.this, search.class);
			it1.putExtra("id", id);
			it1.putExtra("str", "");
			startActivity(it1);
			return true;
		case 3:
			Intent it2 = new Intent(ffmain.this, ffmain.class);
			it2.putExtra("login_id", id);
			startActivity(it2);
			finish();
			return true;
		case 4:
			Intent it3 = new Intent(ffmain.this, main.class);
			startActivity(it3);
			Toast.makeText(this, "로그아웃되었습니다", 0).show();
			finish();
		default:
			return super.onContextItemSelected(item);
		}
	}
	

}
