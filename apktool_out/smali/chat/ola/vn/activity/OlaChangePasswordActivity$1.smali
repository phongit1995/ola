.class Lchat/ola/vn/activity/OlaChangePasswordActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaChangePasswordActivity;->b(S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaChangePasswordActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaChangePasswordActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity$1;->a:Lchat/ola/vn/activity/OlaChangePasswordActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChangePasswordActivity$1;->a:Lchat/ola/vn/activity/OlaChangePasswordActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->finish()V

    return-void
.end method
