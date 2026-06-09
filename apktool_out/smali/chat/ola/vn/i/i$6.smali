.class final Lchat/ola/vn/i/i$6;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/util/List;Landroid/content/Context;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/i/i$6;->a:Ljava/util/List;

    iput-object p2, p0, Lchat/ola/vn/i/i$6;->b:Landroid/content/Context;

    iput-object p3, p0, Lchat/ola/vn/i/i$6;->c:Ljava/lang/String;

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

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/i/i$6;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/i/i$6;->b:Landroid/content/Context;

    const p3, 0x7f0f0691

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/i/i$6;->b:Landroid/content/Context;

    iget-object p2, p0, Lchat/ola/vn/i/i$6;->c:Ljava/lang/String;

    const/4 p3, 0x0

    invoke-static {p1, p2, p3, p3}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
