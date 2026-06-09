.class Lchat/ola/vn/me/c$6;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/c;->h()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/c$6;->a:Lchat/ola/vn/me/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3
    .annotation build Landroid/annotation/TargetApi;
        value = 0x15
    .end annotation

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->r()I

    move-result v0

    if-ltz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/c$6;->a:Lchat/ola/vn/me/c;

    invoke-static {v0}, Lchat/ola/vn/me/c;->k(Lchat/ola/vn/me/c;)Lchat/ola/vn/view/OlaListView;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->r()I

    move-result v1

    sget-object v2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v2}, Lchat/ola/vn/r/a/e;->s()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/view/OlaListView;->setSelectionFromTop(II)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/c$6;->a:Lchat/ola/vn/me/c;

    invoke-static {v0}, Lchat/ola/vn/me/c;->k(Lchat/ola/vn/me/c;)Lchat/ola/vn/view/OlaListView;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaListView;->setSelection(I)V

    return-void
.end method
