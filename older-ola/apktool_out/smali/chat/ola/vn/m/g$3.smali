.class Lchat/ola/vn/m/g$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/g;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/g;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/g;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/g$3;->a:Lchat/ola/vn/m/g;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    iget-object p1, p0, Lchat/ola/vn/m/g$3;->a:Lchat/ola/vn/m/g;

    const-string v0, "/mall/new?p=0"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/m/g;->f(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method
