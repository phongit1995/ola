.class Lchat/ola/vn/m/o$8;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/o;->a_(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/o;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/o;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/o$8;->a:Lchat/ola/vn/m/o;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x49

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/m/o$8;->a:Lchat/ola/vn/m/o;

    invoke-static {p1}, Lchat/ola/vn/m/o;->c(Lchat/ola/vn/m/o;)Landroid/view/View;

    move-result-object p1

    const/4 p2, 0x4

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/m/o$8;->a:Lchat/ola/vn/m/o;

    invoke-static {p1}, Lchat/ola/vn/m/o;->c(Lchat/ola/vn/m/o;)Landroid/view/View;

    move-result-object p1

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method
