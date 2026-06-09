.class public Lchat/ola/vn/view/OlaListView;
.super Landroid/widget/ListView;


# instance fields
.field a:Z

.field protected b:Landroid/widget/ListAdapter;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/widget/ListView;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/view/OlaListView;->a:Z

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/OlaListView;->b:Landroid/widget/ListAdapter;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/widget/ListView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/view/OlaListView;->a:Z

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/OlaListView;->b:Landroid/widget/ListAdapter;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/ListView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/view/OlaListView;->a:Z

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/OlaListView;->b:Landroid/widget/ListAdapter;

    return-void
.end method


# virtual methods
.method protected layoutChildren()V
    .locals 1

    :try_start_0
    invoke-super {p0}, Landroid/widget/ListView;->layoutChildren()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/view/OlaListView;->a:Z
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void

    :catch_1
    iget-boolean v0, p0, Lchat/ola/vn/view/OlaListView;->a:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :try_start_1
    iput-boolean v0, p0, Lchat/ola/vn/view/OlaListView;->a:Z

    iget-object v0, p0, Lchat/ola/vn/view/OlaListView;->b:Landroid/widget/ListAdapter;

    check-cast v0, Landroid/widget/BaseAdapter;

    invoke-virtual {v0}, Landroid/widget/BaseAdapter;->notifyDataSetChanged()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2

    :catch_2
    :cond_0
    return-void
.end method

.method public bridge synthetic setAdapter(Landroid/widget/Adapter;)V
    .locals 0

    check-cast p1, Landroid/widget/ListAdapter;

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/OlaListView;->setAdapter(Landroid/widget/ListAdapter;)V

    return-void
.end method

.method public setAdapter(Landroid/widget/ListAdapter;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iput-object p1, p0, Lchat/ola/vn/view/OlaListView;->b:Landroid/widget/ListAdapter;

    return-void
.end method
