.class Lchat/ola/vn/me/c$11$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/c$11;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/c$11;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/c$11;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/c$11$1;->a:Lchat/ola/vn/me/c$11;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3
    .annotation build Landroid/annotation/TargetApi;
        value = 0x15
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/me/c$11$1;->a:Lchat/ola/vn/me/c$11;

    iget v0, v0, Lchat/ola/vn/me/c$11;->a:I

    if-ltz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/c$11$1;->a:Lchat/ola/vn/me/c$11;

    iget-object v0, v0, Lchat/ola/vn/me/c$11;->c:Lchat/ola/vn/me/c;

    invoke-static {v0}, Lchat/ola/vn/me/c;->k(Lchat/ola/vn/me/c;)Lchat/ola/vn/view/OlaListView;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/me/c$11$1;->a:Lchat/ola/vn/me/c$11;

    iget v1, v1, Lchat/ola/vn/me/c$11;->a:I

    iget-object v2, p0, Lchat/ola/vn/me/c$11$1;->a:Lchat/ola/vn/me/c$11;

    iget v2, v2, Lchat/ola/vn/me/c$11;->b:I

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/view/OlaListView;->setSelectionFromTop(II)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/c$11$1;->a:Lchat/ola/vn/me/c$11;

    iget-object v0, v0, Lchat/ola/vn/me/c$11;->c:Lchat/ola/vn/me/c;

    invoke-static {v0}, Lchat/ola/vn/me/c;->k(Lchat/ola/vn/me/c;)Lchat/ola/vn/view/OlaListView;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaListView;->setSelection(I)V

    return-void
.end method
