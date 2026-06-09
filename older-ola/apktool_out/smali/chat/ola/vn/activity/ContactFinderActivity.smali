.class public Lchat/ola/vn/activity/ContactFinderActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/text/TextWatcher;
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Lchat/ola/vn/b/ak$b;


# instance fields
.field private e:Landroid/widget/EditText;

.field private f:Landroid/widget/ListView;

.field private g:Lchat/ola/vn/b/ak;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method private C()V
    .locals 1

    new-instance v0, Lchat/ola/vn/activity/ContactFinderActivity$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/ContactFinderActivity$2;-><init>(Lchat/ola/vn/activity/ContactFinderActivity;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method private D()V
    .locals 0

    return-void
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/ContactFinderActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private a(Lchat/ola/vn/message/f;)V
    .locals 3

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f0465

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/ContactFinderActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/activity/ContactFinderActivity$3;

    invoke-direct {v2, p0, v0, p1}, Lchat/ola/vn/activity/ContactFinderActivity$3;-><init>(Lchat/ola/vn/activity/ContactFinderActivity;Ljava/util/List;Lchat/ola/vn/message/f;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private b(Lchat/ola/vn/message/f;)V
    .locals 3

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f0465

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/ContactFinderActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f069f

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/ContactFinderActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0492

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/ContactFinderActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/activity/ContactFinderActivity$4;

    invoke-direct {v2, p0, v0, p1}, Lchat/ola/vn/activity/ContactFinderActivity$4;-><init>(Lchat/ola/vn/activity/ContactFinderActivity;Ljava/util/List;Lchat/ola/vn/message/f;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public B()V
    .locals 2

    const v0, 0x7f0b0073

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ContactFinderActivity;->setContentView(I)V

    const v0, 0x7f090010

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ContactFinderActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090014

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ContactFinderActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0900d4

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ContactFinderActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09031a

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ContactFinderActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/activity/ContactFinderActivity;->f:Landroid/widget/ListView;

    const v0, 0x7f09051b

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/ContactFinderActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/activity/ContactFinderActivity;->e:Landroid/widget/EditText;

    iget-object v0, p0, Lchat/ola/vn/activity/ContactFinderActivity;->e:Landroid/widget/EditText;

    invoke-virtual {v0, p0}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object v0, p0, Lchat/ola/vn/activity/ContactFinderActivity;->e:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/activity/ContactFinderActivity$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/ContactFinderActivity$1;-><init>(Lchat/ola/vn/activity/ContactFinderActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    return-void
.end method

.method protected a()V
    .locals 0

    return-void
.end method

.method public a(ZLchat/ola/vn/message/f;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/ContactFinderActivity;->D()V

    return-void
.end method

.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 0

    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090010

    if-eq p1, v0, :cond_0

    const v0, 0x7f090014

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/ContactFinderActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/ContactFinderActivity;->B()V

    new-instance p1, Lchat/ola/vn/b/ak;

    invoke-direct {p1, p0}, Lchat/ola/vn/b/ak;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/ContactFinderActivity;->g:Lchat/ola/vn/b/ak;

    iget-object p1, p0, Lchat/ola/vn/activity/ContactFinderActivity;->g:Lchat/ola/vn/b/ak;

    invoke-virtual {p1, p0}, Lchat/ola/vn/b/ak;->a(Lchat/ola/vn/b/ak$b;)V

    iget-object p1, p0, Lchat/ola/vn/activity/ContactFinderActivity;->f:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/activity/ContactFinderActivity;->g:Lchat/ola/vn/b/ak;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/activity/ContactFinderActivity;->f:Landroid/widget/ListView;

    invoke-virtual {p1, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/ContactFinderActivity;->f:Landroid/widget/ListView;

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setFastScrollEnabled(Z)V

    invoke-direct {p0}, Lchat/ola/vn/activity/ContactFinderActivity;->C()V

    return-void
.end method

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

    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p2

    if-eqz p2, :cond_2

    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p2

    if-eqz p2, :cond_1

    const/4 p3, 0x2

    if-eq p2, p3, :cond_0

    return-void

    :cond_0
    invoke-direct {p0, p1}, Lchat/ola/vn/activity/ContactFinderActivity;->a(Lchat/ola/vn/message/f;)V

    return-void

    :cond_1
    invoke-direct {p0, p1}, Lchat/ola/vn/activity/ContactFinderActivity;->b(Lchat/ola/vn/message/f;)V

    :cond_2
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/activity/ContactFinderActivity;->g:Lchat/ola/vn/b/ak;

    invoke-virtual {p2}, Lchat/ola/vn/b/ak;->getFilter()Landroid/widget/Filter;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroid/widget/Filter;->filter(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
