package com.example.administrator.postbar;

import android.media.JetPlayer;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ListView;

import java.io.IOError;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.StringTokenizer;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class bar_enter extends AppCompatActivity {

    private ListView postBar_lv;
    private List<Map<String, Object>> listItem;
    private class JsonBean {

    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bar_enter);

        postBar_lv = (ListView)findViewById(R.id.postBar_lv);
        listItem = getListItem();
        BaseAdapter baseAdapter = new BaseAdapter() {
            @Override
            public int getCount() {
                return 0;
            }

            @Override
            public Object getItem(int position) {
                return null;
            }

            @Override
            public long getItemId(int position) {
                return 0;
            }

            @Override
            public View getView(int position, View convertView, ViewGroup parent) {
                return null;
            }
        }

    }

    private List<Map<String, Object>> getListItem() {
        List<Map<String,Object>> listItems = new ArrayList<Map<String,Object>>();
        get();
        for (int i = 0; i < bar_length; i++) {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put(name, bar_name[i]);
            map.put(avatar, bar_avatar[i]);
            map.put(totalPost, bar_totalPost[i]);
            map.put(totalFollow, bar_totalFollow[i]);
            listItems.add(map);
        }
        return  listItems;
    }

    private void get() throws IOException {
        OkHttpClient client = new OkHttpClient();
        Request request = new Request.
                Builder().
                url("http://zuojian100steps.duapp.com/Router.php/bar/bar_info").
                build();
        Response response = client.newCall(request).execute();
        if (response.isSuccessful()) {

        } else {
            throw new IOException("Unexpected code " + response);
        }
    }

}
