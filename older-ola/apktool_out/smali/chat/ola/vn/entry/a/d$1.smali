.class Lchat/ola/vn/entry/a/d$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/a/d;->b(Landroid/content/Context;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/i/m;

.field final synthetic b:Lchat/ola/vn/entry/a/d;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/a/d;Lchat/ola/vn/i/m;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/a/d$1;->b:Lchat/ola/vn/entry/a/d;

    iput-object p2, p0, Lchat/ola/vn/entry/a/d$1;->a:Lchat/ola/vn/i/m;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    iget-object p1, p0, Lchat/ola/vn/entry/a/d$1;->b:Lchat/ola/vn/entry/a/d;

    iget-object p2, p0, Lchat/ola/vn/entry/a/d$1;->b:Lchat/ola/vn/entry/a/d;

    invoke-static {p2}, Lchat/ola/vn/entry/a/d;->a(Lchat/ola/vn/entry/a/d;)[Ljava/lang/String;

    move-result-object p2

    aget-object p2, p2, p3

    iput-object p2, p1, Lchat/ola/vn/entry/a/d;->d:Ljava/lang/Object;

    iget-object p1, p0, Lchat/ola/vn/entry/a/d$1;->b:Lchat/ola/vn/entry/a/d;

    iget-object p1, p1, Lchat/ola/vn/entry/a/d;->e:Lchat/ola/vn/entry/a/c$a;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entry/a/d$1;->b:Lchat/ola/vn/entry/a/d;

    iget-object p1, p1, Lchat/ola/vn/entry/a/d;->e:Lchat/ola/vn/entry/a/c$a;

    iget-object p2, p0, Lchat/ola/vn/entry/a/d$1;->b:Lchat/ola/vn/entry/a/d;

    iget-object p3, p0, Lchat/ola/vn/entry/a/d$1;->b:Lchat/ola/vn/entry/a/d;

    iget-object p3, p3, Lchat/ola/vn/entry/a/d;->d:Ljava/lang/Object;

    invoke-interface {p1, p2, p3}, Lchat/ola/vn/entry/a/c$a;->a(Lchat/ola/vn/entry/a/c;Ljava/lang/Object;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/entry/a/d$1;->a:Lchat/ola/vn/i/m;

    invoke-virtual {p1}, Lchat/ola/vn/i/m;->dismiss()V

    return-void
.end method
