.class Lchat/ola/vn/activity/OlaVipStoreActivity$6;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaVipStoreActivity;->c(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaVipStoreActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaVipStoreActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$6;->a:Lchat/ola/vn/activity/OlaVipStoreActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$6;->a:Lchat/ola/vn/activity/OlaVipStoreActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->a(Lchat/ola/vn/activity/OlaVipStoreActivity;Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$6;->a:Lchat/ola/vn/activity/OlaVipStoreActivity;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$6;->a:Lchat/ola/vn/activity/OlaVipStoreActivity;

    const v2, 0x7f0f00a2

    invoke-virtual {v1, v2}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaVipStoreActivity$6;->a:Lchat/ola/vn/activity/OlaVipStoreActivity;

    const v3, 0x7f0f0250

    invoke-virtual {v2, v3}, Lchat/ola/vn/activity/OlaVipStoreActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    return-void
.end method
