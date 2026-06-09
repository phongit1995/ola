.class Lchat/ola/vn/activity/OlaVipStoreActivity$4;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaVipStoreActivity;->b(Lchat/ola/vn/entity/ah;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/ah;

.field final synthetic b:Lchat/ola/vn/activity/OlaVipStoreActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaVipStoreActivity;Lchat/ola/vn/entity/ah;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$4;->b:Lchat/ola/vn/activity/OlaVipStoreActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$4;->a:Lchat/ola/vn/entity/ah;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p2, :cond_1

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$4;->a:Lchat/ola/vn/entity/ah;

    invoke-virtual {v2}, Lchat/ola/vn/entity/ah;->e()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    invoke-virtual {p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->c([Ljava/lang/String;)V

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$4;->b:Lchat/ola/vn/activity/OlaVipStoreActivity;

    invoke-virtual {p2}, Lchat/ola/vn/activity/OlaVipStoreActivity;->C()V

    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
