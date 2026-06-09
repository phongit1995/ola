.class Lchat/ola/vn/activity/PurchaseKENActivity$9;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/PurchaseKENActivity;->G()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/PurchaseKENActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/PurchaseKENActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$9;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$9;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, ""

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const v2, 0x7f0f02fe

    invoke-static {v0, v2, v1}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;I[Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/activity/PurchaseKENActivity$9;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Lchat/ola/vn/activity/PurchaseKENActivity;Lchat/ola/vn/i/c;)Lchat/ola/vn/i/c;

    return-void
.end method
