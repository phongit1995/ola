.class Lchat/ola/vn/activity/OlaCropImageActivity$3$1;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaCropImageActivity$3;->a(Ljava/lang/String;)V
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

.field final synthetic c:Lchat/ola/vn/activity/OlaCropImageActivity$3;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaCropImageActivity$3;Landroid/app/ProgressDialog;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$3$1;->c:Lchat/ola/vn/activity/OlaCropImageActivity$3;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaCropImageActivity$3$1;->a:Landroid/app/ProgressDialog;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaCropImageActivity$3$1;->b:Ljava/lang/String;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/Void;)Ljava/lang/Void;
    .locals 2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$3$1;->b:Ljava/lang/String;

    invoke-static {p1}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-static {p1}, Lchat/ola/vn/badger/e;->a(Landroid/graphics/Bitmap;)[B

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;[B)V

    new-instance v0, Landroid/graphics/drawable/BitmapDrawable;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->b()Landroid/content/res/Resources;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Landroid/graphics/drawable/BitmapDrawable;-><init>(Landroid/content/res/Resources;Landroid/graphics/Bitmap;)V

    sput-object v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->e:Landroid/graphics/drawable/Drawable;

    const/4 p1, 0x1

    sput-boolean p1, Lchat/ola/vn/activity/OlaBottomTabActivity;->f:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    :goto_0
    const/4 p1, 0x0

    return-object p1
.end method

.method protected a(Ljava/lang/Void;)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$3$1;->c:Lchat/ola/vn/activity/OlaCropImageActivity$3;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaCropImageActivity$3;->a:Landroid/content/Context;

    const v0, 0x7f0f01a8

    invoke-static {p1, v0}, Lchat/ola/vn/util/j;->b(Landroid/content/Context;I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$3$1;->c:Lchat/ola/vn/activity/OlaCropImageActivity$3;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaCropImageActivity$3;->b:Lchat/ola/vn/activity/OlaCropImageActivity$a;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$3$1;->c:Lchat/ola/vn/activity/OlaCropImageActivity$3;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaCropImageActivity$3;->b:Lchat/ola/vn/activity/OlaCropImageActivity$a;

    invoke-interface {p1}, Lchat/ola/vn/activity/OlaCropImageActivity$a;->b_()V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$3$1;->a:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaCropImageActivity$3$1;->a([Ljava/lang/Void;)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaCropImageActivity$3$1;->a(Ljava/lang/Void;)V

    return-void
.end method

.method protected onPreExecute()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$3$1;->a:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
