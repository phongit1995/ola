.class Lchat/ola/vn/entry/b/k$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnDismissListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/k;->onLongClick(Landroid/view/View;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/k;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/k;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/k$2;->a:Lchat/ola/vn/entry/b/k;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDismiss(Landroid/content/DialogInterface;)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/k$2;->a:Lchat/ola/vn/entry/b/k;

    iget-object p1, p1, Lchat/ola/vn/entry/b/k;->a:Lcom/mg/ola/common/widget/OlaTextView;

    sget v0, Lchat/ola/vn/f;->g:I

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/OlaTextView;->setBackgroundColor(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
