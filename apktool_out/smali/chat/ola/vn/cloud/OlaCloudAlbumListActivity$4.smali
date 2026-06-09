.class Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$4;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->a_(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$4;->a:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x10

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$4;->a:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    const/4 p2, 0x0

    invoke-static {p1, p2}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->a(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;Z)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$4;->a:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    const-string p2, "null"

    invoke-static {p1, p2}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->a(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;Ljava/lang/String;)Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$4;->a:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    const-string p2, "null"

    invoke-static {p1, p2}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->b(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$4;->a:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->a(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;Z)V

    const/4 v0, 0x1

    :try_start_0
    aget-object v0, p1, v0

    check-cast v0, Ljava/util/List;

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$4;->a:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    invoke-static {v1}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->b(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$4;->a:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    invoke-static {v1}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->a(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;)Lchat/ola/vn/cloud/a;

    move-result-object v1

    invoke-virtual {v1, v0}, Lchat/ola/vn/cloud/a;->b(Ljava/util/List;)V

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$4;->a:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    invoke-static {v1}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->a(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;)Lchat/ola/vn/cloud/a;

    move-result-object v1

    invoke-virtual {v1, v0}, Lchat/ola/vn/cloud/a;->a(Ljava/util/List;)V

    :goto_0
    const/4 v0, 0x2

    aget-object v1, p1, v0

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$4;->a:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    aget-object p1, p1, v0

    check-cast p1, Ljava/lang/String;

    invoke-static {v1, p1}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->a(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;Ljava/lang/String;)Ljava/lang/String;

    goto :goto_1

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$4;->a:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    const-string v0, "null"

    invoke-static {p1, v0}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->a(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;Ljava/lang/String;)Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$4;->a:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    const-string v0, "null"

    invoke-static {p1, v0}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->b(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;Ljava/lang/String;)Ljava/lang/String;

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$4;->a:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->a(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;)Lchat/ola/vn/cloud/a;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/cloud/a;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$4;->a:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    const-string v0, "null"

    invoke-static {p1, v0}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->a(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;Ljava/lang/String;)Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$4;->a:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    const-string v0, "null"

    invoke-static {p1, v0}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->b(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method
