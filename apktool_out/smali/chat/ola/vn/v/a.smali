.class public Lchat/ola/vn/v/a;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Lchat/ola/vn/v/b;",
        "Ljava/lang/Void;",
        "Lchat/ola/vn/v/b;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Lchat/ola/vn/v/b;)Lchat/ola/vn/v/b;
    .locals 3

    if-eqz p1, :cond_1

    :try_start_0
    array-length v0, p1

    if-lez v0, :cond_1

    const/4 v0, 0x0

    aget-object p1, p1, v0

    if-eqz p1, :cond_0

    iget-object v1, p1, Lchat/ola/vn/v/b;->a:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    iget v1, p1, Lchat/ola/vn/v/b;->c:I

    invoke-static {v1}, Lchat/ola/vn/h/b;->a(I)V

    :cond_0
    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v1}, Lchat/ola/vn/message/g;->e()Ljava/util/List;

    move-result-object v1

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v1, v0}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;Ljava/util/List;I)V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->p()Ljava/util/List;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method protected a(Lchat/ola/vn/v/b;)V
    .locals 0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/v/b;->a()V

    :cond_0
    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Lchat/ola/vn/v/b;

    invoke-virtual {p0, p1}, Lchat/ola/vn/v/a;->a([Lchat/ola/vn/v/b;)Lchat/ola/vn/v/b;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lchat/ola/vn/v/b;

    invoke-virtual {p0, p1}, Lchat/ola/vn/v/a;->a(Lchat/ola/vn/v/b;)V

    return-void
.end method
