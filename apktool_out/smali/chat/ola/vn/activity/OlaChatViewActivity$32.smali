.class Lchat/ola/vn/activity/OlaChatViewActivity$32;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity;->f(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Landroid/app/ProgressDialog;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/activity/OlaChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity;Landroid/app/ProgressDialog;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$32;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$32;->a:Landroid/app/ProgressDialog;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaChatViewActivity$32;->b:Ljava/lang/String;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/Void;)Ljava/lang/Void;
    .locals 3

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$32;->b:Ljava/lang/String;

    invoke-static {p1}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-static {p1}, Lchat/ola/vn/badger/e;->a(Landroid/graphics/Bitmap;)[B

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$32;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$32;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    invoke-static {v0, v1, v2, p1}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;Ljava/lang/String;I[B)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method protected a(Ljava/lang/Void;)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$32;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    const v0, 0x7f0f01ac

    invoke-static {p1, v0}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$32;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    const/4 v0, 0x0

    iput-object v0, p1, Lchat/ola/vn/activity/OlaChatViewActivity;->h:Landroid/graphics/drawable/Drawable;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$32;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    const/4 v0, 0x0

    iput-boolean v0, p1, Lchat/ola/vn/activity/OlaChatViewActivity;->i:Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$32;->c:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->s(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$32;->a:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity$32;->a([Ljava/lang/Void;)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity$32;->a(Ljava/lang/Void;)V

    return-void
.end method

.method protected onPreExecute()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$32;->a:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
