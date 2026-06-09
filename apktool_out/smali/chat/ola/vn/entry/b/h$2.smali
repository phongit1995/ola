.class Lchat/ola/vn/entry/b/h$2;
.super Lcom/mg/ola/common/d/a/a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/h;->c()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/e;

.field final synthetic b:Lchat/ola/vn/entry/b/h;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/h;IZLchat/ola/vn/entity/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/h$2;->b:Lchat/ola/vn/entry/b/h;

    iput-object p4, p0, Lchat/ola/vn/entry/b/h$2;->a:Lchat/ola/vn/entity/e;

    invoke-direct {p0, p2, p3}, Lcom/mg/ola/common/d/a/a;-><init>(IZ)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/entry/b/h$2;->b:Lchat/ola/vn/entry/b/h;

    invoke-static {p1}, Lchat/ola/vn/entry/b/h;->d(Lchat/ola/vn/entry/b/h;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/entry/b/h$2;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/m/g;->b(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method
