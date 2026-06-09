.class final Lchat/ola/vn/i/i$11;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;)Landroid/app/Dialog;
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

    iput-object p1, p0, Lchat/ola/vn/i/i$11;->a:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/i/i$11;->a:Landroid/content/Context;

    invoke-static {p2}, Lchat/ola/vn/activity/PurchaseKENActivity;->a(Landroid/content/Context;)V

    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
