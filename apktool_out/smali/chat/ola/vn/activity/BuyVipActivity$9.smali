.class Lchat/ola/vn/activity/BuyVipActivity$9;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/BuyVipActivity;->K()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/activity/BuyVipActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/BuyVipActivity;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$9;->b:Lchat/ola/vn/activity/BuyVipActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity$9;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3

    if-nez p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity$9;->b:Lchat/ola/vn/activity/BuyVipActivity;

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity$9;->a:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/activity/BuyVipActivity$9;->b:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/BuyVipActivity;->e(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/entity/ac;

    move-result-object v1

    iget v1, v1, Lchat/ola/vn/entity/ac;->d:I

    const/4 v2, 0x0

    invoke-virtual {p2, v0, v1, v2}, Lchat/ola/vn/activity/BuyVipActivity;->a(Ljava/lang/String;IS)V

    :cond_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
