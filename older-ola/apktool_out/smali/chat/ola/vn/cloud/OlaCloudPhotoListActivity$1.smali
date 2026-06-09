.class Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$1;->b:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    iput-object p2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$1;->a:Ljava/util/List;

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
    iget-object p2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$1;->b:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    invoke-static {p2}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->a(Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;)Lchat/ola/vn/cloud/b;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/cloud/b;->g()Ljava/util/List;

    move-result-object p2

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$1;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    array-length v3, v0

    if-ge v2, v3, :cond_1

    iget-object v3, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$1;->a:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/i;

    invoke-interface {p2, v3}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    invoke-virtual {v3}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v0, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->E()Lchat/ola/vn/entity/l;

    move-result-object v2

    iget-object v2, v2, Lchat/ola/vn/entity/l;->b:Ljava/lang/String;

    invoke-virtual {p2, v2, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;[Ljava/lang/String;S)V

    iget-object p2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$1;->b:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    invoke-static {p2}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->a(Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;)Lchat/ola/vn/cloud/b;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/cloud/b;->f()V

    iget-object p2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$1;->b:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    invoke-static {p2}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->a(Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;)Lchat/ola/vn/cloud/b;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/cloud/b;->notifyDataSetChanged()V

    :goto_1
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
