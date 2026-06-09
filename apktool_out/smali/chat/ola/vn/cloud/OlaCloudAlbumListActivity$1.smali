.class Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$1;->b:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    iput-object p2, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$1;->a:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 4

    if-eqz p2, :cond_0

    goto :goto_1

    :cond_0
    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$1;->b:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    invoke-static {p2}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->a(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;)Lchat/ola/vn/cloud/a;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/cloud/a;->f()Ljava/util/List;

    move-result-object p2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$1;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/l;

    invoke-interface {p2, v1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, v1, Lchat/ola/vn/entity/l;->b:Ljava/lang/String;

    const/4 v3, 0x0

    invoke-virtual {v2, v1, v3}, Lchat/ola/vn/network/OlaNetworkService;->q(Ljava/lang/String;S)V

    goto :goto_0

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$1;->b:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    invoke-static {p2}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->a(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;)Lchat/ola/vn/cloud/a;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/cloud/a;->e()V

    iget-object p2, p0, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity$1;->b:Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;

    invoke-static {p2}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->a(Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;)Lchat/ola/vn/cloud/a;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/cloud/a;->notifyDataSetChanged()V

    :goto_1
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
