.class Lchat/ola/vn/activity/OlaBottomTabActivity$1;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaBottomTabActivity;->F()V
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
.field final synthetic a:Lchat/ola/vn/activity/OlaBottomTabActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaBottomTabActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$1;->a:Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/Void;)Ljava/lang/Void;
    .locals 2

    const/4 p1, 0x1

    :try_start_0
    sput-boolean p1, Lchat/ola/vn/activity/OlaBottomTabActivity;->f:Z

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/h/b;->c(Ljava/lang/String;)[B

    move-result-object p1

    const/4 v0, 0x0

    array-length v1, p1

    invoke-static {p1, v0, v1}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object p1

    if-eqz p1, :cond_0

    new-instance v0, Landroid/graphics/drawable/BitmapDrawable;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$1;->a:Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-virtual {v1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Landroid/graphics/drawable/BitmapDrawable;-><init>(Landroid/content/res/Resources;Landroid/graphics/Bitmap;)V

    sput-object v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->e:Landroid/graphics/drawable/Drawable;
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
    sget-object p1, Lchat/ola/vn/activity/OlaBottomTabActivity;->e:Landroid/graphics/drawable/Drawable;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$1;->a:Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->e:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p1, v0}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBottomTabActivity$1;->a([Ljava/lang/Void;)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBottomTabActivity$1;->a(Ljava/lang/Void;)V

    return-void
.end method
