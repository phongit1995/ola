.class Lchat/ola/vn/m/v$8;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/v;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/v;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/v;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/v$8;->a:Lchat/ola/vn/m/v;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/m/v$8;->a:Lchat/ola/vn/m/v;

    iget-object p1, p1, Lchat/ola/vn/m/v;->a:Lchat/ola/vn/entity/e;

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/e;->j(I)V

    iget-object p1, p0, Lchat/ola/vn/m/v$8;->a:Lchat/ola/vn/m/v;

    invoke-virtual {p1}, Lchat/ola/vn/m/v;->c()V

    iget-object p1, p0, Lchat/ola/vn/m/v$8;->a:Lchat/ola/vn/m/v;

    invoke-virtual {p1}, Lchat/ola/vn/m/v;->v()V

    return-void
.end method
