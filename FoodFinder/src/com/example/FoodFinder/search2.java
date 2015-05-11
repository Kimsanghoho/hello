package com.example.FoodFinder;

import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.util.ArrayList;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import android.R.color;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.Paint.FontMetricsInt;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.ContextMenu;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ContextMenu.ContextMenuInfo;
import android.view.View.OnClickListener;
import android.webkit.WebView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RatingBar;
import android.widget.RatingBar.OnRatingBarChangeListener;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

public class search2 extends FragmentActivity {

	public RelativeLayout mainLayout;
	public GoogleMap map;
	String resname = null;
	String id = null;
	String foods = null, addr = null, tel = null, intro = null,
			innerTag = null, putresname = null, number = null;
	int tempcnt = 0;
	double lat = 37.514983, lng = 126.758453, avg_score = 0.0;
	boolean isEnd = false;
	boolean ifRaingbar = false;
	float userRating=0.0f;
	class comment {
		String nick = null;
		String sub = null;
		String score = null;
	}
	ImageView img;

	ArrayList<comment> comment_list = new ArrayList<comment>();

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.search2);

		Intent now_it = getIntent();
		resname = now_it.getStringExtra("resname");
		id = now_it.getStringExtra("login_id");

		TextView fd = (TextView) findViewById(R.id.resname);
		fd.setText(resname);

		// ���
		final EditText co = (EditText) findViewById(R.id.comment);
		Button send_btn = (Button) findViewById(R.id.send_btn);
		
		//����â
		img = (ImageView) findViewById(R.id.btn_click);
		registerForContextMenu(img);

		
		
		// �Է¹�ư ��������..
		send_btn.setOnClickListener(new OnClickListener() {
			public void onClick(View view) {
				if(ifRaingbar){
				try {

					String serviceUrl = "http://jellybean.dongyangmirae.kr/android_add_comment.jsp?id=";

					String co_1 = co.getText().toString();
					String co_2 = java.net.URLEncoder.encode(new String(co_1
							.getBytes("UTF-8")));

					String resname2 = java.net.URLEncoder.encode(new String(
							resname.getBytes("UTF-8")));

					// http://jellybean.dongyangmirae.kr/android_add_comment.jsp?id=***&comment=****&restaurant=*****&score=*****

					String strURL = serviceUrl + id + "&comment=" + co_2
							+ "&restaurant=" + resname2 + "&score="+userRating;
					URL url = new URL(strURL);

					XmlPullParserFactory factory = XmlPullParserFactory
							.newInstance();
					XmlPullParser parser = factory.newPullParser();

					parser.setInput(url.openStream(), "utf-8");

					int eventType = parser.getEventType();
					boolean bSet = false;

					while (eventType != XmlPullParser.END_DOCUMENT) {

						switch (eventType) {

						// �̺�Ʈ Ÿ���� ��ť��Ʈ�� ������ ���
						case XmlPullParser.START_DOCUMENT:
							break;

						// �̺�Ʈ Ÿ���� START_TAG�� ���(��: <name>)
						case XmlPullParser.START_TAG:
							// �±� �̸��� ������
							String tag = parser.getName();
							// �±� �̸��� <name>, <address>�� ���
							if (tag.equals("comment")) {
								bSet = true;
							}
							break;

						// �̺�Ʈ Ÿ���� END_TAG�� ���(��: </name>)
						case XmlPullParser.END_TAG:
							break;

						// �̺�Ʈ Ÿ���� �±� ������ �������� ���� ������ ���� (��: <name>������</name>)
						case XmlPullParser.TEXT:
							// �±�(<name>, <address>) ������ ������ ����
							if (bSet) {
								if (parser.getText().equals("true")) {
									Toast.makeText(view.getContext(),
											"����� ��ϵƾ��!", 0).show();
									Intent it = new Intent(search2.this, search2.class);
									it.putExtra("resname", resname);
									it.putExtra("login_id", id);
									startActivity(it);
									finish();
									
								} else {
									Toast.makeText(view.getContext(), "�����Ф�", 0)
											.show();
								}
							}

							// �̺�Ʈ Ÿ���� ��ť��Ʈ�� ���� ���
						case XmlPullParser.END_DOCUMENT:
							break;

						}

						// ���� �̺�Ʈ Ÿ���� �Ҵ�
						eventType = parser.next();

					}
				} catch (Exception e) {

					// ���ܻ��� �޽��� ���
				}
				}else{
					Toast.makeText(view.getContext(), "������ �Է����ּ���!", 0).show();
				}
			}
		});

		// ���� ���̾ƿ� ��ü ����
		mainLayout = (RelativeLayout) findViewById(R.id.mainLayout);

		// ���� ��ü ����
		map = ((SupportMapFragment) getSupportFragmentManager()
				.findFragmentById(R.id.map)).getMap();

		// ��ġ Ȯ���Ͽ� ��ġ ǥ�� ����
		startLocationService();

		try {
			putresname = java.net.URLEncoder.encode(new String(resname
					.getBytes("UTF-8")));
			String serviceUrl = "http://jellybean.dongyangmirae.kr/android_restaurant_info.jsp?res=";

			String strURL = serviceUrl + putresname;
			URL url = new URL(strURL);

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();

			parser.setInput(url.openStream(), "utf-8");

			int eventType = parser.getEventType();
			boolean bSet = false;

			while (eventType != XmlPullParser.END_DOCUMENT) {

				switch (eventType) {

				// �̺�Ʈ Ÿ���� ��ť��Ʈ�� ������ ���
				case XmlPullParser.START_DOCUMENT:
					break;

				// �̺�Ʈ Ÿ���� START_TAG�� ���(��: <name>)
				case XmlPullParser.START_TAG:
					innerTag = parser.getName();
					break;

				// �̺�Ʈ Ÿ���� END_TAG�� ���(��: </name>)
				case XmlPullParser.END_TAG:
					break;

				// �̺�Ʈ Ÿ���� �±� ������ �������� ���� ������ ���� (��: <name>������</name>)
				case XmlPullParser.TEXT:
					// �±�(<name>, <address>) ������ ������ ����
					String content = parser.getText();
					if (innerTag.equals("foods"))
						foods = content;
					if (innerTag.equals("addr"))
						addr = content;
					if (innerTag.equals("tel"))
						tel = content;
					if (innerTag.equals("intro"))
						intro = content;
					if (innerTag.equals("lat"))
						lat = Double.parseDouble(content);
					if (innerTag.equals("lng"))
						lng = Double.parseDouble(content);
					break;

				// �̺�Ʈ Ÿ���� ��ť��Ʈ�� ���� ���
				case XmlPullParser.END_DOCUMENT:

					break;

				}

				// ���� �̺�Ʈ Ÿ���� �Ҵ�
				eventType = parser.next();

			}
		} catch (Exception e) {
			Toast.makeText(this, "1/�����߻�" + e, 0).show();
		}

		try {
			putresname = java.net.URLEncoder.encode(new String(resname
					.getBytes("UTF-8")));
			String serviceUrl = "http://jellybean.dongyangmirae.kr/android_show_comment.jsp?res=";

			String strURL = serviceUrl + putresname;
			URL url = new URL(strURL);

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();

			parser.setInput(url.openStream(), "utf-8");

			int eventType = parser.getEventType();

			while (!isEnd) {
				Boolean bset = false;
				comment comt = null;
				while (eventType != XmlPullParser.END_DOCUMENT) {

					switch (eventType) {

					// �̺�Ʈ Ÿ���� ��ť��Ʈ�� ������ ���
					case XmlPullParser.START_DOCUMENT:
						break;

					// �̺�Ʈ Ÿ���� START_TAG�� ���(��: <name>)
					case XmlPullParser.START_TAG:
						innerTag = parser.getName();
						if(innerTag.equals("comment")){
							comt = new comment();
							bset=true;
						}
						break;

					// �̺�Ʈ Ÿ���� END_TAG�� ���(��: </name>)
					case XmlPullParser.END_TAG:
						if (parser.getName().equals("comment"))
							comment_list.add(comt);

						if (parser.getName().equals("comments"))
							isEnd = true;
						break;

					// �̺�Ʈ Ÿ���� �±� ������ �������� ���� ������ ���� (��: <name>������</name>)
					case XmlPullParser.TEXT:
						// �±�(<name>, <address>) ������ ������ ����
						String content = new String(parser.getText());
						
						if (innerTag.equals("nick"))
							comt.nick = content;
						if (innerTag.equals("sub"))
							comt.sub = content;
						if (innerTag.equals("score"))
							comt.score = content;
						
						if (innerTag.equals("avg"))
							avg_score = Double.parseDouble(content);
						if (innerTag.equals("number"))
							number = content;
						break;

					// �̺�Ʈ Ÿ���� ��ť��Ʈ�� ���� ���
					case XmlPullParser.END_DOCUMENT:
						break;

					}

					// ���� �̺�Ʈ Ÿ���� �Ҵ�
					eventType = parser.next();

				}
			}
		} catch (Exception e) {
			//Toast.makeText(this, "10/�����߻�" + e, 0).show();
		}

		TextView tv_resname = (TextView) findViewById(R.id.resname);
		tv_resname.setText(resname);

		TextView tv_foods = (TextView) findViewById(R.id.textViewfoods);
		tv_foods.setText(foods);

		TextView tv_addr = (TextView) findViewById(R.id.textView_addr);
		tv_addr.setText(addr);

		TextView tv_tel = (TextView) findViewById(R.id.textView_tel);
		tv_tel.setText(tel);

		TextView tv_intro = (TextView) findViewById(R.id.TextView_intro);
		tv_intro.setText(intro);

		TextView tv_score = (TextView) findViewById(R.id.res_score);
		tv_score.setText(" " + avg_score + "��/" + number + "��");

		RatingBar res_ratingbar = (RatingBar) findViewById(R.id.res_ratingbar);
		res_ratingbar.setRating((float) avg_score);

		RatingBar user_ratingbar = (RatingBar) findViewById(R.id.RatingBar_userRating);
		user_ratingbar
				.setOnRatingBarChangeListener(new OnRatingBarChangeListener() {

					@Override
					public void onRatingChanged(RatingBar ratingBar,
							float rating, boolean fromUser) {
						if (rating != 0.0) {
							ifRaingbar = true;
						} else {
							ifRaingbar = false;
						}
						userRating=rating;
					}
				});

		LinearLayout outll = (LinearLayout) findViewById(R.id.comment_outlinear);

		for (int i = 0; i < comment_list.size(); i++) {
			LinearLayout innerll = new LinearLayout(this);
			innerll.setOrientation(LinearLayout.VERTICAL);

			TextView nickandscore_tv = new TextView(this);
			nickandscore_tv.setText(comment_list.get(i).nick+" / "+comment_list.get(i).score + "��");
			innerll.addView(nickandscore_tv);

			TextView sub_tv = new TextView(this);
			sub_tv.setText(comment_list.get(i).sub);
			sub_tv.setTextColor(Color.BLACK);
			innerll.addView(sub_tv);
			outll.addView(innerll);
		}

		WebView wb_ResImg = (WebView) findViewById(R.id.resImg_webview);
		try {
			putresname = java.net.URLEncoder.encode(new String(resname
					.getBytes("UTF-8")));
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		wb_ResImg
				.loadUrl("http://jellybean.dongyangmirae.kr/android_res_img.jsp?res="
						+ putresname);
		showCurrentLocation(lat, lng);
		map.setMyLocationEnabled(true);
	}

	// @Override
	// public void onResume() {
	//
	// map.setMyLocationEnabled(true);
	// }
	//
	// @Override
	// public void onPause() {
	// super.onPause();
	//
	// // �� ��ġ �ڵ� ǥ�� disable
	// map.setMyLocationEnabled(false);
	// }

	/**
	 * ���� ��ġ Ȯ���� ���� ������ �޼ҵ�
	 */
	private void startLocationService() {
		// ��ġ ������ ��ü ����
		LocationManager manager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);

		// ������ ��ü ����
		GPSListener gpsListener = new GPSListener();
		long minTime = 100000;
		float minDistance = 0;

		// GPS ��� ��ġ ��û
		manager.requestLocationUpdates(LocationManager.GPS_PROVIDER, minTime,
				minDistance, gpsListener);

		// ��Ʈ��ũ ��� ��ġ ��û
		manager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER,
				minTime, minDistance, gpsListener);

	}

	private class GPSListener implements LocationListener {
		/**
		 * ��ġ ������ Ȯ�εǾ��� �� ȣ��Ǵ� �޼ҵ�
		 */
		public void onLocationChanged(Location location) {
		}

		public void onProviderDisabled(String provider) {
		}

		public void onProviderEnabled(String provider) {
		}

		public void onStatusChanged(String provider, int status, Bundle extras) {
		}

	}

	/**
	 * ���� ��ġ�� ������ �����ֱ� ���� ������ �޼ҵ�
	 * 
	 * @param latitude
	 * @param longitude
	 */
	private void showCurrentLocation(Double latitude, Double longitude) {
		// ���� ��ġ�� �̿��� LatLon ��ü ����
		LatLng curPoint = new LatLng(latitude, longitude);

		map.animateCamera(CameraUpdateFactory.newLatLngZoom(curPoint, 14));

		// ���� ���� ����. �������� ��쿡�� GoogleMap.MAP_TYPE_TERRAIN, ���� ������ ��쿡��
		// GoogleMap.MAP_TYPE_SATELLITE
		map.setMapType(GoogleMap.MAP_TYPE_NORMAL);

		// ���� ��ġ ������ �������� ǥ���ϱ� ���� ������ �޼ҵ�
		showAllBankItems(latitude, longitude);
	}

	/**
	 * �������� ǥ���ϱ� ���� ������ �޼ҵ�
	 */
	private void showAllBankItems(Double latitude, Double longitude) {
		MarkerOptions markerOpt = new MarkerOptions();
		markerOpt.position(new LatLng(latitude, longitude));
		markerOpt.title("��" + resname);

		markerOpt.icon(BitmapDescriptorFactory.fromResource(R.drawable.home));
		map.addMarker(markerOpt);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}
	public void onCreateContextMenu(ContextMenu menu, View v,
			ContextMenuInfo menuInfo) {
	
		
			
		
	
		super.onCreateContextMenu(menu, v, menuInfo);

		menu.setHeaderIcon(android.R.drawable.btn_star);

		menu.setHeaderTitle("����");
		menu.add(0, 1, 0, "���� �缳��");
		menu.add(0, 2, 0, "�˻�");
	
		
	}

	@Override
	public boolean onContextItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case 1:
			Intent it = new Intent(search2.this, select.class);

			startActivity(it);
			return true;
		case 2:
			
			Intent it1 = new Intent(search2.this, search.class);

			startActivity(it1);
			return true;
		
		default:
			return super.onContextItemSelected(item);
		}
	}
}