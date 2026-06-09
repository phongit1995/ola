.class Lchat/ola/vn/activity/OlaChatViewActivity$7;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChatViewActivity;->ae()V
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
.field final synthetic a:Lchat/ola/vn/activity/OlaChatViewActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/Void;)Ljava/lang/Void;
    .locals 3

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    const/4 v0, 0x1

    iput-boolean v0, p1, Lchat/ola/vn/activity/OlaChatViewActivity;->i:Z

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    invoke-static {p1, v1, v2}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;Ljava/lang/String;I)[B

    move-result-object p1

    const/4 v1, 0x0

    if-eqz p1, :cond_0

    array-length v2, p1

    if-lez v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {v2, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->c(Lchat/ola/vn/activity/OlaChatViewActivity;Z)Z

    new-instance v0, Ljava/io/ByteArrayInputStream;

    array-length v2, p1

    invoke-direct {v0, p1, v1, v2}, Ljava/io/ByteArrayInputStream;-><init>([BII)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    new-instance v1, Landroid/graphics/drawable/BitmapDrawable;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-virtual {v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Landroid/graphics/drawable/BitmapDrawable;-><init>(Landroid/content/res/Resources;Ljava/io/InputStream;)V

    :goto_0
    iput-object v1, p1, Lchat/ola/vn/activity/OlaChatViewActivity;->h:Landroid/graphics/drawable/Drawable;

    goto :goto_1

    :cond_0
    sget-object p1, Lchat/ola/vn/activity/OlaBottomTabActivity;->e:Landroid/graphics/drawable/Drawable;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    sget-object v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->e:Landroid/graphics/drawable/Drawable;

    iput-object v0, p1, Lchat/ola/vn/activity/OlaChatViewActivity;->h:Landroid/graphics/drawable/Drawable;

    goto :goto_1

    :cond_1
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/h/b;->c(Ljava/lang/String;)[B

    move-result-object p1

    if-eqz p1, :cond_2

    array-length v0, p1

    if-lez v0, :cond_2

    new-instance v0, Ljava/io/ByteArrayInputStream;

    array-length v2, p1

    invoke-direct {v0, p1, v1, v2}, Ljava/io/ByteArrayInputStream;-><init>([BII)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    new-instance v1, Landroid/graphics/drawable/BitmapDrawable;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-virtual {v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Landroid/graphics/drawable/BitmapDrawable;-><init>(Landroid/content/res/Resources;Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_2
    :goto_1
    const/4 p1, 0x0

    return-object p1
.end method

.method protected a(Ljava/lang/Void;)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaChatViewActivity;->h:Landroid/graphics/drawable/Drawable;

    if-eqz p1, :cond_1

    invoke-static {}, Lcom/mg/ola/common/d/g;->g()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->k(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/FrameLayout;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaChatViewActivity;->h:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->k(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/FrameLayout;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a:Lchat/ola/vn/activity/OlaChatViewActivity;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaChatViewActivity;->h:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a([Ljava/lang/Void;)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity$7;->a(Ljava/lang/Void;)V

    return-void
.end method
