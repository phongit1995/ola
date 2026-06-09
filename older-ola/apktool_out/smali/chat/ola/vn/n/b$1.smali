.class final Lchat/ola/vn/n/b$1;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/n/b;->a(Landroid/content/Context;DDILchat/ola/vn/n/b$a;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Landroid/content/Context;",
        "Ljava/lang/Void;",
        "Ljava/util/List<",
        "Landroid/location/Address;",
        ">;>;"
    }
.end annotation


# instance fields
.field final synthetic a:D

.field final synthetic b:D

.field final synthetic c:I

.field final synthetic d:Lchat/ola/vn/n/b$a;


# direct methods
.method constructor <init>(DDILchat/ola/vn/n/b$a;)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/n/b$1;->a:D

    iput-wide p3, p0, Lchat/ola/vn/n/b$1;->b:D

    iput p5, p0, Lchat/ola/vn/n/b$1;->c:I

    iput-object p6, p0, Lchat/ola/vn/n/b$1;->d:Lchat/ola/vn/n/b$a;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Landroid/content/Context;)Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/List<",
            "Landroid/location/Address;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    aget-object p1, p1, v0

    new-instance v0, Landroid/location/Geocoder;

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    invoke-direct {v0, p1, v1}, Landroid/location/Geocoder;-><init>(Landroid/content/Context;Ljava/util/Locale;)V

    iget-wide v1, p0, Lchat/ola/vn/n/b$1;->a:D

    iget-wide v3, p0, Lchat/ola/vn/n/b$1;->b:D

    iget v5, p0, Lchat/ola/vn/n/b$1;->c:I

    invoke-virtual/range {v0 .. v5}, Landroid/location/Geocoder;->getFromLocation(DDI)Ljava/util/List;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method protected a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroid/location/Address;",
            ">;)V"
        }
    .end annotation

    if-nez p1, :cond_0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/n/b$1;->d:Lchat/ola/vn/n/b$a;

    invoke-interface {p1}, Lchat/ola/vn/n/b$a;->a()V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/n/b$1;->d:Lchat/ola/vn/n/b$a;

    invoke-interface {v0, p1}, Lchat/ola/vn/n/b$a;->a(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Landroid/content/Context;

    invoke-virtual {p0, p1}, Lchat/ola/vn/n/b$1;->a([Landroid/content/Context;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/util/List;

    invoke-virtual {p0, p1}, Lchat/ola/vn/n/b$1;->a(Ljava/util/List;)V

    return-void
.end method
