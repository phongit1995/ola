.class final Lchat/ola/vn/i/i$13;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/i/i;->d(Landroid/content/Context;)Landroid/app/Dialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/i/i$13;->a:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    invoke-static {}, Lchat/ola/vn/c;->x()Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p2, p0, Lchat/ola/vn/i/i$13;->a:Landroid/content/Context;

    invoke-static {p2}, Lchat/ola/vn/util/n;->b(Landroid/content/Context;)Z

    move-result p2

    if-eqz p2, :cond_1

    sget-boolean p2, Lchat/ola/vn/h;->a:Z

    if-eqz p2, :cond_1

    iget-object p2, p0, Lchat/ola/vn/i/i$13;->a:Landroid/content/Context;

    invoke-static {p2}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->a(Landroid/content/Context;)V

    goto :goto_0

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/i/i$13;->a:Landroid/content/Context;

    invoke-static {p2}, Lchat/ola/vn/activity/BuyVipActivity;->a(Landroid/content/Context;)V

    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
