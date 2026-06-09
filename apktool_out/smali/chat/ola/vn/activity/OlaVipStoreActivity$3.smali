.class Lchat/ola/vn/activity/OlaVipStoreActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaVipStoreActivity;->a(Lchat/ola/vn/entity/ah;)V
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

    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$3;->b:Lchat/ola/vn/activity/OlaVipStoreActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$3;->a:Lchat/ola/vn/entity/ah;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p2, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$3;->a:Lchat/ola/vn/entity/ah;

    invoke-virtual {v0}, Lchat/ola/vn/entity/ah;->e()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->p(Ljava/lang/String;)V

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$3;->b:Lchat/ola/vn/activity/OlaVipStoreActivity;

    invoke-virtual {p2}, Lchat/ola/vn/activity/OlaVipStoreActivity;->C()V

    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
