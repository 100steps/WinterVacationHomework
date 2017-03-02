package com.example.administrator.postbar;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.IOException;
import java.util.Map;

import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;


public class register extends AppCompatActivity {

    private EditText user_name_et,user_password_et,user_password2_et;
    private Button register;
    public String user_name,user_password,user_password2;
    private final Gson gson = new Gson();
    private class JsonBean {
        private String result;
        private String reason;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        user_name_et = (EditText)findViewById(R.id.editText3);
        user_password_et = (EditText)findViewById(R.id.editText4);
        user_password2_et = (EditText)findViewById(R.id.editText5);
        register = (Button)findViewById(R.id.button_register);
        register.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                user_name = user_name_et.getText().toString();
                user_password = user_password_et.getText().toString();
                user_password2 = user_password2_et.getText().toString();
                if (checkRegister(user_name,user_password)) {

                } else {

                }

            }
        });
    }

    public boolean checkRegister(String user_name,String user_password) throws IOException{
        OkHttpClient client = new OkHttpClient();

        RequestBody body = new FormBody.Builder().
            add("user_name",user_name).
            add("user_password",user_password).
            build();
        Request request = new Request.Builder().
                url("http://100heiheidekeren.duapp.com/test/bce-php-sdk-0.8.21/BosClient.php?action=register").
                post(body).
                build();
        Response response = client.newCall(request).execute();
        if (response.isSuccessful()) {
            Gson gson = new Gson();
            java.lang.reflect.Type type = new TypeToken<JsonBean>() {}.getType();
            JsonBean jsonBean = gson.fromJson(response.body().string(), type);
            if (jsonBean.result == "success") {
                return true;
            } else {
                return false;
            }
        } else {
            throw new IOException("Unexpected code " + response);
        }

    }

}
