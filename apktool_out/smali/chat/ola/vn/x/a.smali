.class public Lchat/ola/vn/x/a;
.super Landroid/os/AsyncTask;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/String;",
        "Ljava/lang/Integer;",
        "Ljava/util/List<",
        "Lchat/ola/vn/x/c;",
        ">;>;"
    }
.end annotation


# instance fields
.field a:Lchat/ola/vn/x/d;

.field b:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/x/a;->b:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/x/d;)Lchat/ola/vn/x/a;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/x/a;->a:Lchat/ola/vn/x/d;

    return-object p0
.end method

.method protected varargs a([Ljava/lang/String;)Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lchat/ola/vn/x/c;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    aget-object p1, p1, v0

    iput-object p1, p0, Lchat/ola/vn/x/a;->b:Ljava/lang/String;

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/x/a;->b:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/x/e;->a(Ljava/lang/String;)Ljava/util/List;

    move-result-object p1

    new-instance v0, Lchat/ola/vn/e/m;

    invoke-direct {v0}, Lchat/ola/vn/e/m;-><init>()V

    invoke-static {p1, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method protected a(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/x/c;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/x/a;->a:Lchat/ola/vn/x/d;

    if-eqz v0, :cond_1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/x/a;->a:Lchat/ola/vn/x/d;

    iget-object v0, p0, Lchat/ola/vn/x/a;->b:Ljava/lang/String;

    invoke-interface {p1, v0}, Lchat/ola/vn/x/d;->a(Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/x/a;->a:Lchat/ola/vn/x/d;

    iget-object v1, p0, Lchat/ola/vn/x/a;->b:Ljava/lang/String;

    invoke-interface {v0, v1, p1}, Lchat/ola/vn/x/d;->a(Ljava/lang/String;Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/String;

    invoke-virtual {p0, p1}, Lchat/ola/vn/x/a;->a([Ljava/lang/String;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/util/List;

    invoke-virtual {p0, p1}, Lchat/ola/vn/x/a;->a(Ljava/util/List;)V

    return-void
.end method
