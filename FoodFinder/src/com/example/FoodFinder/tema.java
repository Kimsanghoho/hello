package com.example.FoodFinder;

import java.io.UnsupportedEncodingException;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ImageView;

public class tema extends Activity {
	String tema_1 = "�ѽ�";
	String addr = null;
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		final String tema_2 = "���";
		final String tema_3 = "�Ͻ�";
		final String tema_4 = "�߽�";
		final String tema_5 = "�߽�";
		final String tema_6 = "��Ÿ";

		setContentView(R.layout.tema);


		ImageView tema1 = (ImageView) findViewById(R.id.tema1);
		ImageView tema2 = (ImageView) findViewById(R.id.tema2);
		ImageView tema3 = (ImageView) findViewById(R.id.tema3);
		ImageView tema4 = (ImageView) findViewById(R.id.tema4);

		ImageView tema6 = (ImageView) findViewById(R.id.tema6);

		tema1.setOnClickListener(new OnClickListener() {
			public void onClick(View view) {

			 addr = "groupsearch.jsp?group=";

				Intent it = new Intent(tema.this, recommend2.class);
				it.putExtra("foodname", tema_1);
				it.putExtra("addr", addr);

				startActivity(it);

			}
		});
		tema2.setOnClickListener(new OnClickListener() {
			public void onClick(View view) {

			 addr = "groupsearch.jsp?group=";

				Intent it = new Intent(tema.this, recommend2.class);
				it.putExtra("foodname", tema_2);
				it.putExtra("addr", addr);

				startActivity(it);

			}
		});
		tema3.setOnClickListener(new OnClickListener() {
			public void onClick(View view) {

			 addr = "groupsearch.jsp?group=";

				Intent it = new Intent(tema.this, recommend2.class);
				it.putExtra("foodname", tema_3);
				it.putExtra("addr", addr);

				startActivity(it);

			}
		});
		tema4.setOnClickListener(new OnClickListener() {
			public void onClick(View view) {

			 addr = "groupsearch.jsp?group=";

				Intent it = new Intent(tema.this, recommend2.class);
				it.putExtra("foodname", tema_4);
				it.putExtra("addr", addr);

				startActivity(it);

			}
		});
		
		tema6.setOnClickListener(new OnClickListener() {
			public void onClick(View view) {

			 addr = "groupsearch.jsp?group=";

				Intent it = new Intent(tema.this, recommend2.class);
				it.putExtra("foodname", tema_6);
				it.putExtra("addr", addr);

				startActivity(it);

			}
		});
		

	}

	public boolean onKeyDown(int keyCode, KeyEvent event) {

		if (keyCode == KeyEvent.KEYCODE_BACK) {
			AlertDialog.Builder alertDlg = new AlertDialog.Builder(this);

			alertDlg.setMessage("���� �Ͻðڽ��ϱ�?");
			alertDlg.setPositiveButton("��",
					new DialogInterface.OnClickListener() { // Ȯ�� ��ư
						@Override
						public void onClick(DialogInterface dialog,
								int whichButton) {

							System.exit(0); // �ý��� ����

						}
					});
			alertDlg.setNegativeButton("�ƴϿ�",
					new DialogInterface.OnClickListener() { // ��� ��ư
						@Override
						public void onClick(DialogInterface dialog,
								int whichButton) {

							dialog.cancel();
						}
					});
			AlertDialog alert = alertDlg.create();
			alert.setTitle("FoodFinder"); // �˸�â ��� Ÿ��Ʋ
			alert.show();
		}
		return false;
	}
}
