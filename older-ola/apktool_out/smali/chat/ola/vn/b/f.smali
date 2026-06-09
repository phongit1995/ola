.class public Lchat/ola/vn/b/f;
.super Landroid/widget/BaseAdapter;


# instance fields
.field private a:Landroid/widget/BaseAdapter;

.field private b:Lchat/ola/vn/b/e;

.field private c:Lchat/ola/vn/b/g;

.field private d:I

.field private e:I


# direct methods
.method public constructor <init>(Lchat/ola/vn/b/e;Lchat/ola/vn/b/g;)V
    .locals 2

    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/b/f;->b:Lchat/ola/vn/b/e;

    iput-object p2, p0, Lchat/ola/vn/b/f;->c:Lchat/ola/vn/b/g;

    iget-object v0, p0, Lchat/ola/vn/b/f;->c:Lchat/ola/vn/b/g;

    invoke-virtual {p1}, Lchat/ola/vn/b/e;->getViewTypeCount()I

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/g;->b(I)V

    invoke-virtual {p1}, Lchat/ola/vn/b/e;->getViewTypeCount()I

    move-result v0

    iput v0, p0, Lchat/ola/vn/b/f;->d:I

    invoke-virtual {p2}, Lchat/ola/vn/b/g;->getViewTypeCount()I

    move-result p2

    iput p2, p0, Lchat/ola/vn/b/f;->e:I

    iput-object p1, p0, Lchat/ola/vn/b/f;->a:Landroid/widget/BaseAdapter;

    return-void
.end method


# virtual methods
.method public a(Landroid/widget/BaseAdapter;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/f;->a:Landroid/widget/BaseAdapter;

    return-void
.end method

.method public getCount()I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/f;->a:Landroid/widget/BaseAdapter;

    invoke-virtual {v0}, Landroid/widget/BaseAdapter;->getCount()I

    move-result v0

    return v0
.end method

.method public getItem(I)Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/f;->a:Landroid/widget/BaseAdapter;

    invoke-virtual {v0, p1}, Landroid/widget/BaseAdapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public getItemId(I)J
    .locals 2

    int-to-long v0, p1

    return-wide v0
.end method

.method public getItemViewType(I)I
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b/f;->a:Landroid/widget/BaseAdapter;

    iget-object v1, p0, Lchat/ola/vn/b/f;->b:Lchat/ola/vn/b/e;

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/f;->b:Lchat/ola/vn/b/e;

    invoke-virtual {v0, p1}, Lchat/ola/vn/b/e;->getItemViewType(I)I

    move-result p1

    return p1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/f;->c:Lchat/ola/vn/b/g;

    invoke-virtual {v0, p1}, Lchat/ola/vn/b/g;->getItemViewType(I)I

    move-result p1

    return p1
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/f;->a:Landroid/widget/BaseAdapter;

    invoke-virtual {v0, p1, p2, p3}, Landroid/widget/BaseAdapter;->getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public getViewTypeCount()I
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b/f;->b:Lchat/ola/vn/b/e;

    invoke-virtual {v0}, Lchat/ola/vn/b/e;->getViewTypeCount()I

    move-result v0

    iget-object v1, p0, Lchat/ola/vn/b/f;->c:Lchat/ola/vn/b/g;

    invoke-virtual {v1}, Lchat/ola/vn/b/g;->getViewTypeCount()I

    move-result v1

    add-int/2addr v0, v1

    return v0
.end method
