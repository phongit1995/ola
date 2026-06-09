.class Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->c(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$3;->a:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$3;->a:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->a(Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;Z)V

    iget-object v0, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$3;->a:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    const v1, 0x7f0f00a2

    const v2, 0x7f0f02fe

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void
.end method
