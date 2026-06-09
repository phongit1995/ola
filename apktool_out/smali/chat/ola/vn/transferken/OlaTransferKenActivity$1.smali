.class Lchat/ola/vn/transferken/OlaTransferKenActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnDismissListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/transferken/OlaTransferKenActivity;->a(S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/transferken/OlaTransferKenActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/transferken/OlaTransferKenActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity$1;->a:Lchat/ola/vn/transferken/OlaTransferKenActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDismiss(Landroid/content/DialogInterface;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/transferken/OlaTransferKenActivity$1;->a:Lchat/ola/vn/transferken/OlaTransferKenActivity;

    invoke-virtual {p1}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
